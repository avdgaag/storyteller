require 'spec_helper'

describe CompletionsController do

  describe "POST 'create'" do
    describe 'routing' do
      it { expect(post: '/stories/1/complete').to route_to('completions#create', story_id: '1') }
    end

    describe 'response' do
      let(:story) { build_stubbed :story }
      let(:user)  { create :user, :confirmed }

      before do
        sign_in :user, user
        Story.should_receive(:find).with(story.id.to_s).and_return(story)
        story.should_receive(:complete)
        post :create, story_id: story.id
      end

      it { should redirect_to("/stories/#{story.id}") }
      it { should respond_with(:redirect) }
      it { should set_the_flash.to('Story marked as ready') }
    end
  end

end
