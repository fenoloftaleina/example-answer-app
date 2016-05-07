require 'rails_helper'

describe Episodes::Updater do
  subject { Episodes::Updater.new(current_user, episode.id, params) }

  let(:episode) { create(:episode) }

  describe '#call' do
    let(:updater) { double(call: nil) }

    shared_examples 'episode updater' do
      it 'returns a result with the same but possibly changed episode' do
        expect(subject.call.object.id).to eq(episode.id)
      end

      it 'calls appropriate updater' do
        expect(updater).to receive(:call)

        subject.call
      end
    end

    context 'admin' do
      let(:current_user) { build_stubbed(:admin) }
      let(:params) { { episode: attributes_for(:episode) } }

      before do
        allow(Episodes::Internal::AdminUpdater).to receive(:new).with(
          episode, params[:episode]
        ).and_return(updater)
      end

      it_behaves_like 'episode updater'
    end

    context 'user' do
      let(:current_user) { build_stubbed(:user) }
      let(:watched) { [true, false].sample }
      let(:params) { { episode: { watched: watched } } }

      before do
        allow(Episodes::Internal::UserUpdater).to receive(:new).with(
          current_user, episode, watched
        ).and_return(updater)
      end

      it_behaves_like 'episode updater'

      it 'uses custom serializer' do
        expect(subject.call.serializer).to eq(
          UserTvShowSerializer::EpisodeWithUserWatchedSerializer
        )
      end

      context 'no :watched in params' do
        let(:params) { { episode: {} } }

        it 'fails with parameter missing' do
          expect { subject.call }.to raise_error(ActionController::ParameterMissing)
        end
      end
    end
  end
end
