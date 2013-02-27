require 'spec_helper'

describe EpicsController do
  let(:user)    { create :user, :confirmed }
  let(:project) { build_stubbed :project, id: '9' }

  before do
    Project.stub(:find).with('9').and_return(project)
    sign_in :user, create(:user, :confirmed)
  end

  describe 'GET index' do
    describe 'routing' do
      it { expect(get: '/projects/9/epics').to route_to('epics#index', project_id: '9') }
    end

    describe 'response' do
      before { get :index, project_id: '9' }
      it { should render_template('index') }
      it { should respond_with(:success) }
      it { should_not set_the_flash }
      it { should assign_to(:epics) }
    end
  end

  describe 'GET new' do
    describe 'routing' do
      it { expect(get: '/projects/9/epics/new').to route_to('epics#new', project_id: '9') }
    end

    describe 'response' do
      before { get :new, project_id: '9' }
      it { should render_template('new') }
      it { should respond_with(:success) }
      it { should_not set_the_flash }
      it { should assign_to(:epic).with_kind_of(Epic) }

      it 'builds a new record' do
        expect(assigns(:epic)).to be_new_record
      end
    end
  end

  describe 'GET show' do
    describe 'routing' do
      it { expect(get: '/projects/9/epics/1').to route_to('epics#show', id: '1', project_id: '9') }
    end

    describe 'response' do
      let(:epic) { build_stubbed :epic }

      before do
        project.stub_chain(:epics, :find).with('1').and_return(epic)
        get :show, id: '1', project_id: '9'
      end

      it { should render_template('show') }
      it { should respond_with(:success) }
      it { should_not set_the_flash }
      it { should assign_to(:epic).with_kind_of(Epic) }
      it { expect(assigns(:epic)).to be_decorated }
    end
  end

  describe 'GET edit' do
    describe 'routing' do
      it { expect(get: '/projects/9/epics/1/edit').to route_to('epics#edit', id: '1', project_id: '9') }
    end

    describe 'response' do
      let(:epic) { build_stubbed :epic }

      before do
        project.stub_chain(:epics, :find).with('1').and_return(epic)
        get :edit, id: '1', project_id: '9'
      end

      it { should render_template('edit') }
      it { should respond_with(:success) }
      it { should_not set_the_flash }
      it { should assign_to(:epic).with_kind_of(Epic) }
    end
  end

  describe 'POST create' do
    describe 'routing' do
      it { expect(post: '/projects/9/epics').to route_to('epics#create', project_id: '9') }
    end

    describe 'response' do
      before { post :create, epic: attr, project_id: '9' }

      context 'with valid params' do
        let(:attr) { attributes_for :epic }
        it { should redirect_to("/projects/9/epics/#{Epic.last.id}") }
        it { should set_the_flash.to('Epic created') }
        it { should respond_with(:redirect) }
      end

      context 'with invalid params' do
        let(:attr) { attributes_for :epic, :invalid }
        it { should render_template('new') }
        it { should respond_with(:success) }
        it { should_not set_the_flash }
        it { should assign_to(:epic).with_kind_of(Epic) }
      end
    end
  end

  describe 'PUT update' do
    describe 'routing' do
      it { expect(put: '/projects/9/epics/1').to route_to('epics#update', id: '1', project_id: '9') }
    end

    describe 'response' do
      let(:epic) { create :epic }

      before do
        project.stub_chain(:epics, :find).with('1').and_return(epic)
        put :update, id: '1', epic: attr, project_id: '9'
      end

      context 'with valid params' do
        let(:attr) { attributes_for :epic }
        it { should redirect_to("/projects/9/epics/#{Epic.last.id}") }
        it { should set_the_flash.to('Epic updated') }
        it { should respond_with(:redirect) }
      end

      context 'with invalid params' do
        let(:attr) { attributes_for :epic, :invalid }
        it { should render_template('edit') }
        it { should respond_with(:success) }
        it { should_not set_the_flash }
        it { should assign_to(:epic).with_kind_of(Epic) }
      end
    end
  end

  describe 'DELETE destroy' do
    describe 'routing' do
      it { expect(delete: '/projects/9/epics/1').to route_to('epics#destroy', id: '1', project_id: '9') }
    end

    describe 'response' do
      let(:epic) { create :epic }

      before do
        project.stub_chain(:epics, :find).with('1').and_return(epic)
        delete :destroy, id: '1', project_id: '9'
      end

      it { should respond_with(:redirect) }
      it { should redirect_to('/projects/9/epics') }
      it { should set_the_flash.to('Epic destroyed') }
    end
  end
end
