require 'spec_helper'

describe ComparisonsController do
  it_should_behave_like 'authenticated controller' do
    def make_request
      get :show, story_id: '1', left: '1', right: '2', project_id: project.to_param
    end
  end

  context 'signed in', signed_in: true do

    describe "GET 'show'" do
      describe 'routing' do
        it { expect(get: 'projects/9/stories/1/compare/1/2').to route_to('comparisons#show', story_id: '1', left: '1', right: '2', project_id: '9') }
      end

      describe 'response' do
        let(:project) { build_stubbed :project, owner: signed_in_user }

        before do
          Project.should_receive(:find).with('9').and_return(project)
          get :show, story_id: '1', left: '1', right: '2', project_id: '9'
        end

        it { should respond_with(:success) }
        it { should render_template('show') }
        it { should assign_to(:comparison) }
        it { should_not set_the_flash }
      end
    end

  end
end
