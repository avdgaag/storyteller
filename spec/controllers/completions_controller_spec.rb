require 'spec_helper'

describe CompletionsController do
  it_should_behave_like 'authenticated controller' do
    def make_request
      post :create, project_id: project.to_param, story_id: '1'
    end
  end

  context 'signed in', signed_in: true do
    let(:project) { build_stubbed :project, id: '9', owner: signed_in_user }

    before do
      Project.stub!(:find).with('9').and_return(project)
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
end
