require 'spec_helper'

describe RevertionsController do

  describe "POST 'create'" do
    let(:story) { create :story }

    before do
      sign_in :user, create(:user, :confirmed)
      Story.should_receive(:find).with(story.id.to_s).and_return(story)
      story.should_receive(:revert_to!).with(33)
      post :create, story_id: story.id, version: '33'
    end

    it { should redirect_to("/stories/#{story.id}") }
    it { should respond_with(:redirect) }
    it { should set_the_flash.to('User story is reverted to version 33') }
  end

end
