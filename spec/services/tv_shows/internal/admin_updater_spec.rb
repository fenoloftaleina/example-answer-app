require 'rails_helper'

describe TvShows::Internal::AdminUpdater do
  subject { TvShows::Internal::AdminUpdater.new(tv_show, params) }

  let(:tv_show) { create(:tv_show) }
  let(:params) { { title: title } }
  let(:title) { 'Dexter' }

  it 'updates the tv show' do
    subject.call

    expect(tv_show.title).to eq(title)
  end
end
