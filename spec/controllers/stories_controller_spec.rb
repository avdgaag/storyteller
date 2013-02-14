require 'spec_helper'

describe StoriesController do

  before { sign_in :user, create(:user, :confirmed) }

  describe "GET 'index'" do
    describe 'routing' do
      it { expect(get: '/stories').to route_to('stories#index') }
      it { expect(get: '/stories/page/2').to route_to('stories#index', page: '2') }
      it { expect(stories_path).to eql('/stories') }
      it { expect(paged_stories_path(page: '2')).to eql('/stories/page/2') }
    end

    describe 'response' do
      before { get :index }
      it { should render_template('index') }
      it { should respond_with(:success) }
      it { should assign_to(:stories) }
      it { should_not set_the_flash }
    end

    it 'uses filters as scopes' do
      Story.should_receive(:done).and_return(Story.scoped)
      get :index, filter: 'done'
    end

    it 'does nothing when using invalid filter' do
      Story.should_not_receive(:foo)
      get :index, filter: 'foo'
    end
  end

  describe 'GET "show"' do
    let(:story) { double }

    before do
      story.stub!(:decorate).and_return(story)
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

  describe 'GET "edit"' do
    let(:story) { double }

    before do
      Story.stub!(:find).and_return(story)
      get :edit, id: '1'
    end

    describe 'routing' do
      it { expect(get: '/stories/1/edit').to route_to('stories#edit', id: '1') }
      it { expect(edit_story_path('1')).to eql('/stories/1/edit') }
    end

    describe 'response' do
      it { should render_template('edit') }
      it { should respond_with(:success) }
      it { should assign_to(:story).with(story) }
      it { should_not set_the_flash }
    end
  end

  describe 'GET "new"' do
    let(:story) { double epic: epic, :epic= => epic }
    let(:epic)  { double }

    before do
      Story.stub!(:new).and_return(story)
      Epic.stub!(:find).and_return(epic)
    end

    context 'nested under epics' do
      before { get :new, epic_id: '1' }

      describe 'routing' do
        it { expect(get: '/epics/1/stories/new').to route_to('stories#new', epic_id: '1') }
        it { expect(new_epic_story_path(1)).to eql('/epics/1/stories/new') }
      end

      describe 'response' do
        it { should render_template('new') }
        it { should respond_with(:success) }
        it { should assign_to(:story).with(story) }
        it { should assign_to(:epic).with(epic) }
        it { should_not set_the_flash }
      end
    end

    context 'on its own' do
      before { get :new }

      describe 'routing' do
        it { expect(get: '/stories/new').to route_to('stories#new') }
        it { expect(new_story_path).to eql('/stories/new') }
      end

      describe 'response' do
        it { should render_template('new') }
        it { should respond_with(:success) }
        it { should assign_to(:story).with(story) }
        it { should_not set_the_flash }
      end
    end
  end

  describe 'POST "create"' do
    context 'nested under epics' do
      describe 'routing' do
        it { expect(post: '/epics/1/stories').to route_to('stories#create', epic_id: '1') }
      end

      describe 'response' do
        let(:epic) { build_stubbed :epic }

        before do
          Epic.should_receive(:find).with('1').and_return(epic)
          post :create, epic_id: '1', story: attr
        end

        context 'when valid' do
          let(:attr) { attributes_for :story }
          it { should redirect_to("/stories/#{Story.last.id}") }
          it { should respond_with(:redirect) }
          it { should set_the_flash }
        end

        context 'when invalid' do
          let(:attr) { attributes_for :invalid_story }
          it { should render_template('new') }
          it { should respond_with(:success) }
          it { should assign_to(:story).with_kind_of(Story) }
          it { should_not set_the_flash }
        end
      end

      context 'on its own' do
        describe 'routing' do
          it { expect(post: '/stories').to route_to('stories#create') }
        end

        describe 'response' do
          before { post :create, story: attr }

          context 'when valid' do
            let(:attr) { attributes_for :story }
            it { should redirect_to("/stories/#{Story.last.id}") }
            it { should respond_with(:redirect) }
            it { should set_the_flash }
          end

          context 'when invalid' do
            let(:attr) { attributes_for :invalid_story }
            it { should render_template('new') }
            it { should respond_with(:success) }
            it { should assign_to(:story).with_kind_of(Story) }
            it { should_not set_the_flash }
          end
        end
      end
    end
  end

  describe 'PUT "edit"' do
    describe 'routing' do
      it { expect(put: '/stories/1').to route_to('stories#update', id: '1') }
    end

    describe 'response' do
      let(:story) { create :story }

      before do
        put :update, id: story.id, story: attr
      end

      context 'when valid' do
        let(:attr) { attributes_for :story }
        it { should redirect_to("/stories/#{Story.last.id}") }
        it { should respond_with(:redirect) }
        it { should set_the_flash }
      end

      context 'when invalid' do
        let(:attr) { attributes_for :invalid_story }
        it { should render_template('edit') }
        it { should respond_with(:success) }
        it { should assign_to(:story).with_kind_of(Story) }
        it { should_not set_the_flash }
      end
    end
  end
end
