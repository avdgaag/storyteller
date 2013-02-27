require 'spec_helper'

describe CompletionsController do
  let(:project) { build_stubbed :project, id: '9' }
  let(:user)    { create :user, :confirmed }

  before do
    Project.stub!(:find).with('9').and_return(project)
    sign_in :user, user
  end

  describe "POST 'create'" do
    describe 'routing' do
      it { expect(post: '/projects/9/stories/1/complete').to route_to('completions#create', project_id: '9', story_id: '1') }
    end

    describe 'response' do
      let(:story) { build_stubbed :story }

      before do
        project.stub_chain(:stories, :find).and_return(story)
        story.should_receive(:complete)
        post :create, project_id: '9', story_id: story.id
      end

      it { should redirect_to("/projects/9/stories/#{story.id}") }
      it { should respond_with(:redirect) }
      it { should set_the_flash.to('Story marked as ready') }
    end
  end

end
