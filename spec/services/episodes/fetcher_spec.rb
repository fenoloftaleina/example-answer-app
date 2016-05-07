require 'rails_helper'

describe Episodes::Fetcher do
  subject { Episodes::Fetcher.new(user_id, tv_show.id) }

  let!(:user_tv_show) do
    create(:user_tv_show_with_first_of_two_episodes_watched)
  end
  let(:tv_show) { user_tv_show.tv_show }

  let!(:another_user_tv_show) do
    create(:user_tv_show_with_first_of_two_episodes_watched)
  end

  describe '#call' do
    shared_examples 'episode loader' do
      it 'fetches the specified tv show' do
        expect(subject.call.object).to eq(tv_show)
      end

      it 'has two episodes' do
        expect(subject.call.object.episodes.count).to eq(2)
      end
    end

    context 'general scope' do
      let(:user_id) { nil }

      it_behaves_like 'episode loader'
    end

    context 'user scope' do
      let(:user_id) { user_tv_show.user_id }

      it_behaves_like 'episode loader'

      it 'has first episode watched' do
        first_episode = subject.call.object.episodes.first

        expect(first_episode.user_episodes.last.watched).to eq(true)
      end

      it 'has second episode but not watched' do
        second_episode = subject.call.object.episodes.second

        expect(second_episode.user_episodes.try(:last).try(:watched)).
          not_to eq(true)
      end

      it 'creates a result with a custom user serializer' do
        expect(Answer).to receive(:new).with(
          anything, anything, anything, UserTvShowSerializer
        )

        subject.call
      end
    end
  end
end
