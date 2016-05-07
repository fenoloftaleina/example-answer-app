require 'rails_helper'

describe UserTvShowSerializer do
  subject do
    described_class.new(object).serializable_hash.with_indifferent_access
  end

  context 'without loaded association' do
    let(:object) { create(:tv_show) }

    it 'always loads episodes' do
      expect(subject[:episodes]).to eq([])
    end
  end

  context 'with watched episodes' do
    let(:object) do
      Episodes::Fetcher.new(user_tv_show.user_id, user_tv_show.tv_show_id).call.
        object
    end

    let(:user_tv_show) do
      create(:user_tv_show_with_first_of_two_episodes_watched)
    end

    it 'serializes the first episode which is watched' do
      expect(subject[:episodes].first[:watched]).to eq(true)
    end

    it 'serializes the second episode which is not watched' do
      expect(subject[:episodes].second[:watched]).to eq(false)
    end

    it 'has two episodes' do
      expect(subject[:episodes].count).to eq(2)
    end
  end
end
