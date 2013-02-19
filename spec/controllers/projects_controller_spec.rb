require 'spec_helper'

describe ProjectsController do
  let(:user) { create :user, :confirmed }
  before { sign_in :user, user }

  describe 'GET index' do
    describe 'routing' do
      it { expect(get: '/projects').to route_to('projects#index') }
    end

    describe 'response' do
      before { get :index }
      it { should render_template('index') }
      it { should respond_with(:success) }
      it { should_not set_the_flash }
      it { should assign_to(:projects) }
    end
  end

  describe 'GET new' do
    describe 'routing' do
      it { expect(get: '/projects/new').to route_to('projects#new') }
    end

    describe 'response' do
      before { get :new }
      it { should render_template('new') }
      it { should respond_with(:success) }
      it { should_not set_the_flash }
      it { should assign_to(:project).with_kind_of(Project) }

      it 'builds a new record' do
        expect(assigns(:project)).to be_new_record
      end
    end
  end

  describe 'GET show' do
    describe 'routing' do
      it { expect(get: '/projects/1').to route_to('projects#show', id: '1') }
    end

    describe 'response' do
      let(:project) { build_stubbed :project }

      before do
        Project.should_receive(:find).with('1').and_return(project)
        get :show, id: '1'
      end

      it { should render_template('show') }
      it { should respond_with(:success) }
      it { should_not set_the_flash }
      it { should assign_to(:project).with_kind_of(Project) }
      it { expect(assigns(:project)).to be_decorated }
    end
  end

  describe 'GET edit' do
    describe 'routing' do
      it { expect(get: '/projects/1/edit').to route_to('projects#edit', id: '1') }
    end

    describe 'response' do
      let(:project) { build_stubbed :project }

      before do
        Project.should_receive(:find).with('1').and_return(project)
        get :edit, id: '1'
      end

      it { should render_template('edit') }
      it { should respond_with(:success) }
      it { should_not set_the_flash }
      it { should assign_to(:project).with_kind_of(Project) }
    end
  end

  describe 'POST create' do
    describe 'routing' do
      it { expect(post: '/projects').to route_to('projects#create') }
    end

    describe 'response' do
      before { post :create, project: attr }

      context 'with valid params' do
        let(:attr) { attributes_for :project }
        it { should redirect_to("/projects/#{Project.last.id}") }
        it { should set_the_flash.to('Project created') }
        it { should respond_with(:redirect) }
      end

      context 'with invalid params' do
        let(:attr) { attributes_for :project, :invalid }
        it { should render_template('new') }
        it { should respond_with(:success) }
        it { should_not set_the_flash }
        it { should assign_to(:project).with_kind_of(Project) }
      end
    end
  end

  describe 'PUT update' do
    describe 'routing' do
      it { expect(put: '/projects/1').to route_to('projects#update', id: '1') }
    end

    describe 'response' do
      let(:project) { create :project }

      before do
        put :update, id: project.id, project: attr
      end

      context 'with valid params' do
        let(:attr) { attributes_for :project }
        it { should redirect_to("/projects/#{Project.last.id}") }
        it { should set_the_flash.to('Project updated') }
        it { should respond_with(:redirect) }
      end

      context 'with invalid params' do
        let(:attr) { attributes_for :project, :invalid }
        it { should render_template('edit') }
        it { should respond_with(:success) }
        it { should_not set_the_flash }
        it { should assign_to(:project).with_kind_of(Project) }
      end
    end
  end

  describe 'DELETE destroy' do
    describe 'routing' do
      it { expect(delete: '/projects/1').to route_to('projects#destroy', id: '1') }
    end

    describe 'response' do
      let(:project) { create :project }
      before { delete :destroy, id: project.id }
        it { should respond_with(:redirect) }
      it { should redirect_to('/projects') }
      it { should set_the_flash.to('Project destroyed') }
    end
  end
end
