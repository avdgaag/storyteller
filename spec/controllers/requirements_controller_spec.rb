require 'spec_helper'

describe RequirementsController do
  it_should_behave_like 'authenticated controller' do
    def make_request
      post :create, project_id: project.to_param, story_id: '1', requirement: {}
    end
  end

  context 'signed in', signed_in: true do
    let(:project) { build_stubbed :project, id: '9', owner: signed_in_user }
    let(:story)   { build_stubbed :story }

    before do
      Project.stub!(:find).and_return(project)
    end

    describe "POST 'create'" do
      describe 'routing' do
        it { expect(post: '/projects/9/stories/1/requirements').to route_to('requirements#create', project_id: '9', story_id: '1') }
      end

      describe 'response' do
        before do
          project.stub_chain(:stories, :find).with(story.id.to_s).and_return(story)
          post :create, project_id: '9', story_id: story.id, requirement: attr
        end

        context 'with valid attributes' do
          let(:attr) { attributes_for :requirement }
          it { should redirect_to("/projects/9/stories/#{story.id}") }
          it { should respond_with(:redirect) }
          it { should set_the_flash.to('Requirement added') }
        end

        context 'with invalid attributes' do
          let(:attr) { {} }
          it { should redirect_to("/projects/9/stories/#{story.id}") }
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
        it { expect(delete: '/projects/9/stories/1/requirements/2').to route_to('requirements#destroy', project_id: '9', story_id: '1', id: '2') }
      end

      describe 'response' do
        before do
          project.stub_chain(:stories, :find).with(story.id.to_s).and_return(story)
          story.stub_chain('requirements.find').and_return(requirement)
          requirement.should_receive(:destroy)
          delete :destroy, project_id: '9', story_id: story.id, id: requirement.id
        end

        it { should redirect_to("/projects/9/stories/#{story.id}") }
        it { should respond_with(:redirect) }
        it { should set_the_flash.to('Requirement removed') }
      end
    end
  end
end
