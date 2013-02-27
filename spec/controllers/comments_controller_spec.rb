require 'spec_helper'

describe CommentsController do

  describe "POST 'create'" do
    let(:story)   { build_stubbed :story }
    let(:project) { build_stubbed :project }
    let(:user)    { create :user, :confirmed }
    let(:attr)    { attributes_for(:comment) }

    context 'routing' do
      it { expect(post: '/projects/9/stories/1/comments').to route_to('comments#create', story_id: '1', project_id: '9') }
    end

    context 'response' do
      before do
        sign_in :user, user
        Project.should_receive(:find).with(project.to_param).and_return(project)
        project.stub_chain(:stories, :find).and_return(story)
        post :create, story_id: story.to_param, comment: attr, project_id: project.id
      end

      it { should respond_with(:redirect) }
      it { should redirect_to("/projects/#{project.id}/stories/#{story.id}") }

      it 'sets user to current user' do
        expect(assigns(:comment).user).to eql(user)
      end

      context 'when validation succeeds' do
        it { should set_the_flash.to('Comment created') }
      end

      context 'when validation fails' do
        let(:attr) { {} }

        it 'flashes the comments' do
          expect(flash[:comment]).to be_kind_of(Comment)
        end
      end
    end
  end

end
