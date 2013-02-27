require 'spec_helper'

describe ComparisonsController do

  describe "GET 'show'" do
    describe 'routing' do
      it { expect(get: 'projects/9/stories/1/compare/1/2').to route_to('comparisons#show', story_id: '1', left: '1', right: '2', project_id: '9') }
    end

    describe 'response' do
      let(:user)    { create(:user, :confirmed) }
      let(:project) { build_stubbed :project }

      before do
        sign_in :user, user
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
