require 'spec_helper'

describe StoriesController do

  describe "GET 'index'" do
    before { get :index }
    describe 'routing' do
      it { expect(get: '/stories').to route_to('stories#index') }
      it { expect(get: '/stories/page/2').to route_to('stories#index', page: '2') }
      it { expect(stories_path).to eql('/stories') }
      it { expect(paged_stories_path(page: '2')).to eql('/stories/page/2') }
    end

    describe 'response' do
      it { should render_template('index') }
      it { should respond_with(:success) }
      it { should assign_to(:stories) }
      it { should_not set_the_flash }
    end
  end

  describe 'GET "show"' do
    let(:story) { double }

    before do
      Story.stub!(:find).and_return(story)
      get :show, id: '1'
    end

    describe 'routing' do
      it { expect(get: '/stories/1').to route_to('stories#show', id: '1') }
      it { expect(story_path('1')).to eql('/stories/1') }
    end

    describe 'response' do
      it { should render_template('show') }
      it { should respond_with(:success) }
      it { should assign_to(:story).with(story) }
      it { should_not set_the_flash }
    end
  end

end
