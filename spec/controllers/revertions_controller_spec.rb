require 'spec_helper'

describe RevertionsController do
  describe "POST 'create'" do
    let(:user)      { create(:user, :confirmed) }
    let(:revertion) { double 'revertion', revert: double(story: story, version: '33') }
    let(:story)     { build_stubbed :story }

    before do
      sign_in :user, user
      Revertion.should_receive(:new).with(hash_including(user: user, version: '33', story_id: '1')).and_return(revertion)
      post :create, story_id: '1', version: '33'
    end

    it { should redirect_to("/stories/#{story.id}") }
    it { should respond_with(:redirect) }
    it { should set_the_flash.to('User story is reverted to version 33') }
  end

end
