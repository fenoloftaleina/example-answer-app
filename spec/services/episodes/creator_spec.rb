require 'rails_helper'

describe Episodes::Creator do
  subject { Episodes::Creator.new(current_user, tv_show.id, params) }

  describe '#call' do
    let(:current_user) { build_stubbed(:admin) }
    let(:params) do
      { episode: attributes_for(:episode).with_indifferent_access }
    end

    let(:tv_show) { create(:tv_show) }

    it_behaves_like 'everything with permissions'

    it 'creates a new episode' do
      expect { subject.call }.to change { TvShow.count }.by(1)
    end

    it 'creates a tv show from params' do
      expect(subject.call.object.attributes).to include(params[:episode])
    end

    it 'attaches it to the tv show' do
      object = subject.call.object

      expect(tv_show.episodes.last).to eq(object)
    end
  end
end

