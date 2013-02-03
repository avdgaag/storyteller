require 'spec_helper'

describe UsersController do

  describe "GET 'show'" do
    before { get :show }
    it { should respond_with :success }
    it { should render_template('show') }
    it { should render_with_layout('application') }
  end

end
