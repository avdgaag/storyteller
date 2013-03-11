require 'spec_helper'

describe ProjectsController do
  context 'when signed in', signed_in: true do
    let(:involved_projects) { double('involved_projects') }
    let(:project)  { build_stubbed :project, id: '9', owner: signed_in_user }

    before do
      controller.stub(:involved_projects).and_return(involved_projects)
      involved_projects.stub(:find).and_return(project)
      involved_projects.stub(:decorate).and_return(involved_projects)
    end

    describe 'GET last_active' do
      before do
        controller.stub!(:cookies).and_return(cookies)
        get :last_active
      end

      context 'when last active project cookie is set' do
        let(:cookies) { { 'last_active_project_id' => '9' } }
        it { should redirect_to('/projects/9/stories') }
      end

      context 'when no cookie is set' do
        let(:cookies) { { } }
        it { should render_template('index') }
        it { should respond_with(:success) }
        it { should_not set_the_flash }
        it { should assign_to(:projects) }
      end
    end

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

        before do
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

        before do
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
        before do
          project.should_receive(:update_attributes).and_return(success)
          project.stub(:errors).and_return(success ? [] : [:bad])
          put :update, id: project.id, project: {}
        end

        context 'with valid params' do
          let(:success) { true }
          it { should redirect_to("/projects/#{project.to_param}") }
          it { should set_the_flash.to('Project updated') }
          it { should respond_with(:redirect) }
        end

        context 'with invalid params' do
          let(:success) { false }
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
        before do
          project.should_receive(:destroy).and_return(true)
          project.stub(:persisted?).and_return(false)
          delete :destroy, id: project.id
        end

        it { should respond_with(:redirect) }
        it { should redirect_to('/projects') }
        it { should set_the_flash.to('Project destroyed') }
      end
    end
  end
end
