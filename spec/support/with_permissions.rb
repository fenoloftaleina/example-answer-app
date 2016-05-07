shared_examples 'everything with permissions' do
  it 'returns whatever the StopRightThere#with_permissions returns' do
    result = double
    allow(StopRightThere).to receive(:with_permissions).and_return(result)

    expect(subject.call).to eq(result)
  end
end
