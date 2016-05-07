require 'rails_helper'

describe Episodes::Internal::UserUpdater do
  subject { Episodes::Internal::UserUpdater.new(user, episode, watched) }

  let(:episode) { create(:episode) }
  let!(:user) { create(:user) }

  shared_examples 'watched' do
    context 'mark as watched' do
      let(:watched) { true }

      it 'is watched' do
        subject.call

        expect(user_episode_pairs.where(watched: true).exists?).to eq(true)
      end

      it 'is joined only once' do
        subject.call

        expect(user_episode_pairs.count).to eq(1)
      end

      it 'means user has a related tv show' do
        subject.call

        expect(user.tv_shows.where(id: episode.tv_show.id).exists?).to eq(true)
      end
    end
  end

  shared_examples 'not watched' do
    context 'mark as not watched' do
      let(:watched) { false }

      it 'is not watched' do
        subject.call

        expect(user_episode_pairs.where(watched: false).exists?).to eq(true)
      end
    end
  end

  context 'was watched' do
    before do
      create_user_episode(true)
    end

    it_behaves_like 'watched'
    it_behaves_like 'not watched'
  end

  context 'was not watched' do
    context 'join existed' do
      before do
        create_user_episode(false)
      end

      it_behaves_like 'watched'
      it_behaves_like 'not watched'
    end

    context 'join did not exist' do
      it_behaves_like 'watched'

      context 'mark as not watched' do
        let(:watched) { false }

        it 'still has no join between user and episode' do
          subject.call

          expect(user_episode_pairs.exists?).to eq(false)
        end
      end
    end
  end

  def create_user_episode(was_watched)
    create(:user_episode, user_id: user.id, episode_id: episode.id, watched: was_watched)
  end

  def user_episode_pairs
    UserEpisode.where(user_id: user.id, episode_id: episode.id)
  end
end
