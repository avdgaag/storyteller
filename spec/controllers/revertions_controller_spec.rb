require 'spec_helper'

describe RevertionsController do
  let(:project) { build_stubbed :project, id: '9' }
  let(:user)    { create :user, :confirmed }

  before do
    Project.stub!(:find).with('9').and_return(project)
    sign_in :user, user
  end

  describe "POST 'create'" do
    let(:revertion) { double 'revertion', revert: double(story: story, version: '33') }
    let(:story)     { build_stubbed :story }

    before do
      Revertion.should_receive(:new).with(hash_including(user: user, version: '33', story_id: '1')).and_return(revertion)
      post :create, project_id: '9', story_id: '1', version: '33'
    end

    context 'routing' do
      it { expect(post: '/projects/9/stories/1/revertions/2').to route_to('revertions#create', project_id: '9', story_id: '1', version: '2') }
    end

    context 'response' do
      it { should redirect_to("/projects/9/stories/#{story.id}") }
      it { should respond_with(:redirect) }
      it { should set_the_flash.to('User story is reverted to version 33') }
    end
  end
end
