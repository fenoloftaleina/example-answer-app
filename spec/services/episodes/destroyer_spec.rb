require 'rails_helper'

describe Episodes::Destroyer do
  subject { Episodes::Destroyer.new(current_user, episode.id) }

  describe '#call' do
    let(:current_user) { build_stubbed(:admin) }

    let!(:episode) { create(:episode) }

    let(:joins_destroyer) { double(call: nil) }

    before do
      allow(Episodes::Internal::JoinDestroyer).to receive(:new).
        and_return(joins_destroyer)
    end

    it_behaves_like 'everything with permissions'

    it 'destroys the episode' do
      subject.call

      expect(Episode.where(id: episode.id).exists?).to eq(false)
    end

    it 'returns result with the episode object' do
      expect(subject.call.object).to eq(episode)
    end

    it 'calls joins destroyer then destroys episode' do
      ep_double = double
      allow(Episode).to receive(:find).with(episode.id).and_return(ep_double)

      expect(joins_destroyer).to receive(:call).ordered
      expect(ep_double).to receive(:destroy).ordered

      subject.call
    end
  end
end
