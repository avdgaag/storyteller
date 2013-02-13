require 'spec_helper'

describe UsersController do
  describe "GET 'show'" do
    describe 'routing' do
      it { expect(get: '/users/1').to route_to('users#show', id: '1') }
    end

    describe 'response' do
      before { get :show, id: '1' }
      it { should respond_with :success }
      it { should render_template('show') }
      it { should render_with_layout('application') }
    end
  end
end
