require 'spec_helper'

describe StoriesController do
  let(:project) { build_stubbed :project, id: '9' }

  before do
    Project.stub(:find).with('9').and_return(project)
    sign_in :user, create(:user, :confirmed)
  end

  describe "GET 'index'" do
    describe 'routing' do
      it { expect(get: '/projects/9/stories').to route_to('stories#index', project_id: '9') }
      it { expect(get: '/projects/9/stories/page/2').to route_to('stories#index', page: '2', project_id: '9') }
      it { expect(project_stories_path(9)).to eql('/projects/9/stories') }
      it { expect(paged_project_stories_path(9, page: '2')).to eql('/projects/9/stories/page/2') }
    end

    describe 'response' do
      before { get :index, project_id: '9' }
      it { should render_template('index') }
      it { should respond_with(:success) }
      it { should assign_to(:stories) }
      it { should_not set_the_flash }

      it 'remembers the last active project in a cookie' do
        expect(cookies['last_active_project_id']).to eql('9')
      end
    end

    it 'uses filters as scopes' do
      Story.should_receive(:done).and_return(Story.scoped)
      get :index, filter: 'done', project_id: '9'
    end

    it 'does nothing when using invalid filter' do
      Story.should_not_receive(:foo)
      get :index, filter: 'foo', project_id: '9'
    end
  end

  describe 'GET "show"' do
    let(:story) { double to_feature: 'foo bar', to_rb: 'ruby code' }

    describe 'routing' do
      it { expect(get: '/projects/9/stories/1').to route_to('stories#show', id: '1', project_id: '9') }
      it { expect(project_story_path('9', '1')).to eql('/projects/9/stories/1') }
    end

    describe 'response' do
      before do
        story.stub!(:decorate).and_return(story)
        project.stub_chain(:stories, :find).and_return(story)
      end

      describe 'as HTML' do
        before { get :show, id: '1', project_id: '9' }
        it { should render_template('show') }
        it { should respond_with(:success) }
        it { should assign_to(:story).with(story) }
        it { should_not set_the_flash }
      end

      describe 'as .rb' do
        before { get :show, id: '1', project_id: '9', format: 'rb' }

        it 'renders story as plain text' do
          expect(response.body).to eql('ruby code')
          expect(response.content_type).to eql('text/plain')
        end
      end

      describe 'as .feature' do
        before { get :show, id: '1', project_id: '9', format: 'feature' }

        it 'renders story as plain text' do
          expect(response.body).to eql('foo bar')
          expect(response.content_type).to eql('text/plain')
        end
      end
    end
  end

  describe 'GET "edit"' do
    let(:story) { double }

    describe 'routing' do
      it { expect(get: '/projects/9/stories/1/edit').to route_to('stories#edit', id: '1', project_id: '9') }
      it { expect(edit_project_story_path('9', '1')).to eql('/projects/9/stories/1/edit') }
    end

    describe 'response' do
      before do
        project.stub_chain(:stories, :find).and_return(story)
        get :edit, id: '1', project_id: '9'
      end

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
      describe 'routing' do
        it { expect(get: '/projects/9/epics/1/stories/new').to route_to('stories#new', epic_id: '1', project_id: '9') }
        it { expect(new_project_epic_story_path(9, 1)).to eql('/projects/9/epics/1/stories/new') }
      end

      describe 'response' do
        before { get :new, epic_id: '1', project_id:  '9'}
        it { should render_template('new') }
        it { should respond_with(:success) }
        it { should assign_to(:story).with(story) }
        it { should assign_to(:epic).with(epic) }
        it { should_not set_the_flash }
      end
    end

    context 'on its own' do
      describe 'routing' do
        it { expect(get: '/projects/9/stories/new').to route_to('stories#new', project_id: '9') }
        it { expect(new_project_story_path(9)).to eql('/projects/9/stories/new') }
      end

      describe 'response' do
        before { get :new, project_id: '9' }
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
        it { expect(post: '/projects/9/epics/1/stories').to route_to('stories#create', epic_id: '1', project_id: '9') }
      end

      describe 'response' do
        let(:epic) { build_stubbed :epic }

        before do
          Epic.should_receive(:find).with('1').and_return(epic)
          post :create, epic_id: '1', project_id: '9', story: attr
        end

        context 'when valid' do
          let(:attr) { attributes_for :story }
          it { should redirect_to("/projects/9/stories/#{Story.last.id}") }
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
          it { expect(post: '/projects/9/stories').to route_to('stories#create', project_id: '9') }
        end

        describe 'response' do
          before { post :create, story: attr, project_id: '9' }

          context 'when valid' do
            let(:attr) { attributes_for :story }
            it { should redirect_to("/projects/9/stories/#{Story.last.id}") }
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
      it { expect(put: '/projects/9/stories/1').to route_to('stories#update', id: '1', project_id: '9') }
    end

    describe 'response' do
      let(:story) { create :story, project: project }

      before do
        put :update, id: story.id, project_id: '9', story: attr
      end

      context 'when valid' do
        let(:attr) { attributes_for :story }
        it { should redirect_to("/projects/9/stories/#{Story.last.id}") }
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
