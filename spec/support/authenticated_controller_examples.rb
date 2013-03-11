shared_examples_for 'authenticated controller' do
  let(:project) { build_stubbed :project }

  before do
    Project.stub!(:find).with(project.to_param).and_return(project)
  end

  context 'when the user is not involved in the project' do
    before { signed_in }

    it 'raises an error' do
      expect { make_request }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when the user is not signed in', signed_out: true do
    it 'redirects to log in page' do
      make_request
      expect(response).to be_redirect
      expect(response).to redirect_to('/account/sign_in')
    end
  end
end
