require 'spec_helper'

describe AttachmentsController do
  it_should_behave_like 'authenticated controller' do
    def make_request
      post :create, story_id: '1', attachment: {}, project_id: project.to_param
    end
  end

  context 'signed in', signed_in: true do
    let(:story)   { build_stubbed :story }
    let(:project) { build_stubbed :project, owner: signed_in_user }

    before do
      Project.stub!(:find).with(project.to_param).and_return(project)
      project.stub_chain(:stories, :find).and_return(story)
    end

    describe "POST 'create'" do
      let(:attr) { attributes_for(:attachment) }

      context 'routing' do
        it { expect(post: '/projects/9/stories/1/attachments').to route_to('attachments#create', story_id: '1', project_id: '9') }
      end

      context 'response' do
        before do
          post :create, story_id: story.to_param, attachment: attr, project_id: project.id
        end

        it { should respond_with(:redirect) }
        it { should redirect_to("/projects/#{project.id}/stories/#{story.id}") }

        it 'sets user to current user' do
          expect(assigns(:attachment).user).to eql(signed_in_user)
        end

        context 'when validation succeeds' do
          it { should set_the_flash.to('Attachment created') }
        end

        context 'when validation fails' do
          let(:attr) { {} }

          it 'flashes the attachments' do
            expect(flash[:attachment]).to be_kind_of(Attachment)
          end
        end
      end
    end

    describe 'DELETE destroy' do
      let(:attachment) { build_stubbed :attachment, attachable: story }

      describe 'routing' do
        it { expect(delete: '/projects/9/stories/1/attachments/2').to route_to('attachments#destroy', project_id: '9', story_id: '1', id: '2') }
      end

      describe 'response' do
        before do
          story.stub_chain('attachments.find').and_return(attachment)
          attachment.should_receive(:destroy)
          delete :destroy, project_id: project.id, story_id: story.id, id: attachment.id
        end

        it { should redirect_to("/projects/#{project.id}/stories/#{story.id}") }
        it { should respond_with(:redirect) }
        it { should set_the_flash.to('Attachment removed') }
      end
    end
  end
end
