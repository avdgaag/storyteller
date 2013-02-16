require 'spec_helper'

describe EpicsController do
  let(:user) { create :user, :confirmed }
  before { sign_in :user, user }

  describe 'GET index' do
    describe 'routing' do
      it { expect(get: '/epics').to route_to('epics#index') }
    end

    describe 'response' do
      before { get :index }
      it { should render_template('index') }
      it { should respond_with(:success) }
      it { should_not set_the_flash }
      it { should assign_to(:epics) }
    end
  end

  describe 'GET new' do
    describe 'routing' do
      it { expect(get: '/epics/new').to route_to('epics#new') }
    end

    describe 'response' do
      before { get :new }
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
      it { expect(get: '/epics/1').to route_to('epics#show', id: '1') }
    end

    describe 'response' do
      let(:epic) { build_stubbed :epic }

      before do
        Epic.should_receive(:find).with('1').and_return(epic)
        get :show, id: '1'
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
      it { expect(get: '/epics/1/edit').to route_to('epics#edit', id: '1') }
    end

    describe 'response' do
      let(:epic) { build_stubbed :epic }

      before do
        Epic.should_receive(:find).with('1').and_return(epic)
        get :edit, id: '1'
      end

      it { should render_template('edit') }
      it { should respond_with(:success) }
      it { should_not set_the_flash }
      it { should assign_to(:epic).with_kind_of(Epic) }
    end
  end

  describe 'POST create' do
    describe 'routing' do
      it { expect(post: '/epics').to route_to('epics#create') }
    end

    describe 'response' do
      before { post :create, epic: attr }

      context 'with valid params' do
        let(:attr) { attributes_for :epic }
        it { should redirect_to("/epics/#{Epic.last.id}") }
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
      it { expect(put: '/epics/1').to route_to('epics#update', id: '1') }
    end

    describe 'response' do
      let(:epic) { create :epic }

      before do
        put :update, id: epic.id, epic: attr
      end

      context 'with valid params' do
        let(:attr) { attributes_for :epic }
        it { should redirect_to("/epics/#{Epic.last.id}") }
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
      it { expect(delete: '/epics/1').to route_to('epics#destroy', id: '1') }
    end

    describe 'response' do
      let(:epic) { create :epic }
      before { delete :destroy, id: epic.id }
      it { should respond_with(:redirect) }
      it { should redirect_to('/epics') }
      it { should set_the_flash.to('Epic destroyed') }
    end
  end
end
