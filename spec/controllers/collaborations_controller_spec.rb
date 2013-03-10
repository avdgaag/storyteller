require 'spec_helper'

describe CollaborationsController do
  let(:project) { build_stubbed :project }
  let(:user)    { create :user, :confirmed }

  before do
    Project.stub(:find).with(project.to_param).and_return(project)
    sign_in :user, user
  end

  describe "GET 'index'" do
    context 'routing' do
      it { expect(get: '/projects/9/collaborations').to route_to('collaborations#index', project_id: '9') }
    end

    context 'response' do
      before { get :index, project_id: project.id }
      it { should render_template('index') }
      it { should respond_with(:success) }
      it { should_not set_the_flash }
      it { should assign_to(:collaborations) }
      it { should assign_to(:collaboration_request) }
    end
  end

  describe "POST 'create'" do

    context 'routing' do
      it { expect(post: '/projects/9/collaboration_requests').to route_to('collaborations#create', project_id: '9') }
    end

    context 'response' do
      let(:collaboration_request) { double(save: true, invitation?: true) }

      before do
        CollaborationRequest.should_receive(:new).with(project, 'foo').and_return(collaboration_request)
        post :create, collaboration_request: { email: 'foo' }, project_id: project.id
      end

      it { should respond_with(:redirect) }
      it { should redirect_to("/projects/#{project.id}/collaborations") }

      context 'when validation succeeds' do
        it { should set_the_flash.to('Invitation sent') }
      end

      context 'when validation fails' do
        let(:collaboration_request) { double(save: false) }

        it 'flashes the collaborations' do
          expect(flash[:collaboration_request]).to be(collaboration_request)
        end
      end
    end
  end
end
