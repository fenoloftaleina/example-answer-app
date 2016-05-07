require 'rails_helper'

describe TvShowSerializer do
  subject do
    TvShowSerializer.new(object).serializable_hash.with_indifferent_access
  end

  let(:object) { create(:tv_show) }

  shared_examples 'basic TvShowSerializer' do
    equal_keys([:title, :description, :rank, :created_at])
  end

  it_behaves_like 'basic TvShowSerializer'

  context 'without loaded association' do
    it 'has no episodes' do
      expect(subject[:episodes]).to eq(nil)
    end
  end

  context 'with loaded association' do
    let(:object) { TvShow.includes(:episodes).find(tv_show.id) }

    let(:tv_show) { create(:tv_show) }
    let(:episode) { create(:episode, title: 'Two Stories') }

    before do
      tv_show.episodes << episode
    end

    it 'serializes the episode' do
      expect(subject[:episodes].last).to include(
        id: episode.id, title: episode.title)
    end

    it 'has one episode' do
      expect(subject[:episodes].count).to eq(1)
    end
  end
end
