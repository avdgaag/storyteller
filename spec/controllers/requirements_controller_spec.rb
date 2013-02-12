require 'spec_helper'

describe RequirementsController do
  let(:user)  { create :user, :confirmed }
  let(:story) { build_stubbed :story }
  before      { sign_in :user, user }

  describe "POST 'create'" do
    describe 'routing' do
      it { expect(post: '/stories/1/requirements').to route_to('requirements#create', story_id: '1') }
    end

    describe 'response' do
      before do
        Story.should_receive(:find).with(story.id.to_s).and_return(story)
        post :create, story_id: story.id, requirement: attr
      end

      context 'with valid attributes' do
        let(:attr) { attributes_for :requirement }
        it { should redirect_to("/stories/#{story.id}") }
        it { should respond_with(:redirect) }
        it { should set_the_flash.to('Requirement added') }
      end

      context 'with invalid attributes' do
        let(:attr) { {} }
        it { should redirect_to("/stories/#{story.id}") }
        it { should respond_with(:redirect) }

        it 'assigns the invalid requirement to the flash' do
          expect(flash[:requirement]).to be_kind_of(Requirement)
        end
      end

    end
  end

  describe "GET 'destroy'" do
    let(:requirement) { build_stubbed :requirement, story: story }

    describe 'routing' do
      it { expect(delete: '/stories/1/requirements/2').to route_to('requirements#destroy', story_id: '1', id: '2') }
    end

    describe 'response' do
      before do
        Story.should_receive(:find).with(story.id.to_s).and_return(story)
        story.stub_chain('requirements.find').and_return(requirement)
        requirement.should_receive(:destroy)
        delete :destroy, story_id: story.id, id: requirement.id
      end

      it { should redirect_to("/stories/#{story.id}") }
      it { should respond_with(:redirect) }
      it { should set_the_flash.to('Requirement removed') }
    end
  end

end
