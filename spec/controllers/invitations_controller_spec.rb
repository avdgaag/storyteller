require 'spec_helper'

describe InvitationsController do

  describe 'GET "show"' do
    let(:project)    { build_stubbed(:project) }
    let(:invitation) { build_stubbed(:invitation, token: 'foo') }

    describe 'routing' do
      it { expect(get: '/projects/9/invitations/foo').to route_to('invitations#show', project_id: '9', id: 'foo') }
    end

    describe 'response' do
      before do
        Project.should_receive(:find).with(project.to_param).and_return(project)
      end

      def make_request
        get :show, project_id: project.to_param, id: invitation.to_param
      end

      context 'when the token can be found' do
        before do
          project.stub_chain(:invitations, :find_by_token!).and_return(invitation)
        end

        context 'when the user is logged in' do
          let(:user) { create :user, :confirmed }

          before do
            invitation.should_receive(:create_collaboration)
            sign_in user
            make_request
          end

          it { should redirect_to('/') }
          it { should respond_with(:redirect) }
          it { should set_the_flash.to('You can now participate in this project') }
        end

        context 'when the user is not logged in' do
          before { make_request }
          it { should redirect_to('/account/sign_in') }
          it { should respond_with(:redirect) }
          it { should set_the_flash.to('Please log in or sign up to continue') }
          it { should set_session(:return_url).to("http://test.host/projects/#{project.to_param}/invitations/#{invitation.to_param}") }
        end
      end

      context 'when the token cannot be found' do
        it 'raises a not found error' do
          project.stub_chain(:invitations, :find_by_token!).and_raise(ActiveRecord::RecordNotFound)
          expect { make_request }.to raise_error
        end
      end
    end
  end
end
