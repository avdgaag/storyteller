require 'spec_helper'

describe ComparisonsController do

  describe "GET 'show'" do
    describe 'routing' do
      it { expect(get: '/stories/1/compare/1/2').to route_to('comparisons#show', story_id: '1', left: '1', right: '2') }
    end

    describe 'response' do
      before do
        sign_in :user, create(:user, :confirmed)
        get :show, story_id: '1', left: '1', right: '2'
      end
      it { should respond_with(:success) }
      it { should render_template('show') }
      it { should assign_to(:comparison) }
      it { should_not set_the_flash }
    end
  end

end
