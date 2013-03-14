require 'spec_helper'

describe ExportsController do

  it_should_behave_like 'authenticated controller' do
    def make_request
      post :create, story_id: '1', project_id: project.id
    end
  end

  context 'signed in', signed_in: true do
    describe "POST 'create'" do
      let(:story)    { build_stubbed :story }
      let(:project)  { build_stubbed :project, owner: signed_in_user }
      let(:exporter) { double('exporter') }

      context 'routing' do
        it { expect(post: '/projects/9/stories/1/exports').to route_to('exports#create', story_id: '1', project_id: '9') }
      end

      context 'response' do
        before do
          Project.should_receive(:find).with(project.to_param).and_return(project)
          project.stub_chain(:stories, :find).and_return(story)
          exporter.stub!(:export)
          PivotalTrackerExporter.should_receive(:new).with(project).and_return(exporter)
        end

        def make_request
          post :create, story_id: story.to_param, project_id: project.to_param
        end

        context 'alway' do
          before { make_request }
          it { should respond_with(:redirect) }
          it { should redirect_to("/projects/#{project.to_param}/stories/#{story.to_param}") }
        end

        context 'when exporting succeeds' do
          before do
            exporter.should_receive(:export).with(story).and_return(true)
            make_request
          end

          it { should set_the_flash.to("User story #{story.to_param} created in Pivotal Tracker") }
        end

        context 'when exporting fails' do
          before do
            exporter.should_receive(:export).with(story).and_raise(PivotalTrackerExporter::Error)
            make_request
          end

          it { should set_the_flash.to("Exporting failed. Please try again later.") }
        end
      end
    end
  end
end
