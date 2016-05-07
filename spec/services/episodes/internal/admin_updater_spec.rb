require 'rails_helper'

describe Episodes::Internal::AdminUpdater do
  subject { Episodes::Internal::AdminUpdater.new(episode, params) }

  let(:episode) { create(:episode) }
  let(:params) { { title: title } }
  let(:title) { 'Tonight\'s the night' }

  it 'updates the episode' do
    subject.call

    expect(episode.title).to eq(title)
  end
end
