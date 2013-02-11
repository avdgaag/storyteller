require 'spec_helper'

describe CommentsController do

  describe "POST 'create'" do
    let(:story) { build_stubbed :story }
    let(:user)  { create :user, :confirmed }
    let(:attr)  { attributes_for(:comment) }

    context 'routing' do
      it { expect(post: '/stories/1/comments').to route_to('comments#create', story_id: '1') }
    end

    context 'response' do
      before do
        sign_in :user, user
        Story.should_receive(:find).with(story.to_param).and_return(story)
        post :create, story_id: story.to_param, comment: attr
      end

      it { should respond_with(:redirect) }
      it { should redirect_to("/stories/#{story.id}") }

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
