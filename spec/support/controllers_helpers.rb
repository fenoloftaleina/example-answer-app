def service_oriented_action
  let(:service) { double(call: result) }
  let(:result) { Answer.new(double) }

  before do
    allow(service_class).to receive(:new).and_return(service)
  end

  it 'calls render on result' do
    expect(result).to receive(:render)

    action.call
  end

  it 'succeeds' do
    action.call

    expect(response).to be_success
  end

  it 'has proper status' do
    action.call

    expect(response).to have_http_status(
      request.params[:action] == 'create' ? 201 : 200
    )
  end
end
