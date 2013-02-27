require 'spec_helper'

describe Comparison do
  describe 'options' do
    let(:default_options) { { story_id: '1', left: '2', right: '3', project_id: '9' } }
    subject { described_class.new(default_options) }

    %w[story_id left right project_id].each do |option|
      it "requires option #{option}" do
        expect {
          described_class.new(default_options.except(option.to_sym))
        }.to raise_error(KeyError)
      end
    end

    its(:left)  { should be_kind_of(Fixnum) }
    its(:right) { should be_kind_of(Fixnum) }

    it 'takes an optional output argument' do
      output = double
      comparison = described_class.new(default_options.merge(output: output))
      expect(comparison.output).to be(output)
    end
  end

  describe '#diff' do
    it 'shows an HTML diff' do
      story = create :story, body: "foo\nbar"
      story.update_attribute :body, "foo\nbaz"
      diff = described_class.new(story_id: story.id, left: 1, right: 2, project_id: story.project_id).diff
      expect(diff).to eql(<<-DIFF)
<span>foo</span>
<del>bar</del>
<ins>baz</ins>
DIFF
    end
  end
end
