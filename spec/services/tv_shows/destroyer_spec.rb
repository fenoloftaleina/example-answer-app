require 'rails_helper'

describe TvShows::Destroyer do
  subject { TvShows::Destroyer.new(current_user, id) }

  describe '#call' do
    let(:current_user) { build_stubbed(:admin) }

    let!(:tv_show) { create(:tv_show) }
    let(:id) { tv_show.id }

    it_behaves_like 'everything with permissions'

    context 'destroys all' do
      before do
        subject.call
      end

      it 'destroys the tv show' do
        expect(TvShow.where(id: id).exists?).to eq(false)
      end

      it 'destroys user tv shows joins' do
        expect(UserTvShow.where(tv_show_id: id).exists?).to eq(false)
      end

      it 'destroys episodes' do
        expect(Episode.where(tv_show_id: id).exists?).to eq(false)
      end

      it 'destroys user episodes joins' do
        expect(
          UserEpisode.includes(:episode).where(episodes: { tv_show_id: id }).exists?
        ).to eq(false)
      end
    end
  end
end
