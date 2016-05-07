require 'rails_helper'

describe TvShows::Fetcher do
  subject { TvShows::Fetcher.new(user_id, page) }
  let(:page) { nil }

  let!(:user_tv_show) { create(:user_tv_show) }
  let!(:another_user_tv_show) { create(:user_tv_show) }

  describe '#call' do
    context 'general scope' do
      let(:user_id) { nil }

      context 'default page' do
        it 'returns first page of all recently added shows' do
          expect(subject.call.object.first).to eq(another_user_tv_show.tv_show)
        end
      end

      context 'second page' do
        let(:page) { 2 }

        it 'shows first tv show because of 1 per page and desc creation order' do
          expect(subject.call.object.first).to eq(user_tv_show.tv_show)
        end
      end
    end

    context 'user scope' do
      let(:user_id) { user_tv_show.user_id }

      context 'default page' do
        it 'returns first page with his only show' do
          expect(subject.call.object.first).to eq(user_tv_show.tv_show)
        end
      end

      context 'second page' do
        let(:page) { 2 }

        it 'is empty because of 1 per page and only one user tv show' do
          expect(subject.call.object.empty?).to eq(true)
        end
      end
    end
  end
end
