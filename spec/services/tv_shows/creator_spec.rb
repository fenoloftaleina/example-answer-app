require 'rails_helper'

describe TvShows::Creator do
  subject { TvShows::Creator.new(current_user, params) }

  describe '#call' do
    let(:current_user) { build_stubbed(:admin) }
    let(:params) do
      { tv_show: attributes_for(:tv_show).with_indifferent_access }
    end

    it_behaves_like 'everything with permissions'

    it 'creates a new tv show' do
      expect { subject.call }.to change { TvShow.count }.by(1)
    end

    it 'creates a tv show from params' do
      expect(subject.call.object.attributes).to include(params[:tv_show])
    end
  end
end
