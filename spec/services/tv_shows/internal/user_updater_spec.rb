require 'rails_helper'

describe TvShows::Internal::UserUpdater do
  subject { TvShows::Internal::UserUpdater.new(user, tv_show, watching) }

  let(:tv_show) { create(:tv_show) }
  let(:user) { create(:user) }

  shared_examples 'watching or not' do
    context 'will be watching' do
      let(:watching) { true }

      it 'is watching and is joined only once' do
        subject.call

        expect(user.tv_shows.where(id: tv_show.id).count).to eq(1)
      end
    end

    context 'will not be watching' do
      let(:watching) { false }

      it 'is not watching' do
        subject.call

        expect(user.tv_shows.where(id: tv_show.id).exists?).to eq(false)
      end

      it 'does not destroy tv show' do
        subject.call

        expect { tv_show.reload }.not_to raise_error
      end
    end
  end

  context 'was watching' do
    before do
      user.tv_shows << tv_show
    end

    it_behaves_like 'watching or not'
  end

  context 'was not watching' do
    it_behaves_like 'watching or not'
  end
end
