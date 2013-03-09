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
      it { should assign_to(:collaboration) }
    end
  end

  describe "POST 'create'" do

    context 'routing' do
      it { expect(post: '/projects/9/collaborations').to route_to('collaborations#create', project_id: '9') }
    end

    context 'response' do

      context 'when the user does not exist' do
        let(:invitation) { double(save: true) }

        before do
          ActionMailer::Base.deliveries = []
          User.should_receive(:find_by_email).with('foo').and_return(nil)
          project.stub_chain(:invitations, :build).and_return(invitation)
          post :create, email: 'foo', project_id: project.id
        end

        it { should respond_with(:redirect) }
        it { should redirect_to("/projects/#{project.id}/collaborations") }

        context 'when validation succeeds' do
          it { should set_the_flash.to('Invitation sent') }

          it 'sends an email to the user' do
            expect(ActionMailer::Base).to have(1).deliveries
          end
        end

        context 'when validation fails' do
          let(:invitation) { double(save: false) }

          it 'flashes the collaborations' do
            expect(flash[:invitation]).to be(invitation)
          end
        end
      end

      context 'when the user exists' do
        let(:collaboration) { double(save: true, :user= => true) }

        before do
          User.should_receive(:find_by_email).with('foo').and_return(build_stubbed(:user))
          project.stub_chain(:collaborations, :build).and_return(collaboration)
          post :create, email: 'foo', project_id: project.id
        end

        it { should respond_with(:redirect) }
        it { should redirect_to("/projects/#{project.id}/collaborations") }

        context 'when validation succeeds' do
          it { should set_the_flash.to('Collaboration created') }
        end

        context 'when validation fails' do
          let(:collaboration) { double(save: false, :user= => true) }

          it 'flashes the collaborations' do
            expect(flash[:collaboration]).to be(collaboration)
          end
        end
      end
    end
  end
end
