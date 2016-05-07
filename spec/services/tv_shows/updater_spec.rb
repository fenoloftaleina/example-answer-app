require 'rails_helper'

describe TvShows::Updater do
  subject { TvShows::Updater.new(current_user, tv_show.id, params) }

  let(:tv_show) { create(:tv_show) }

  describe '#call' do
    let(:updater) { double(call: nil) }

    shared_examples 'tv_show updater' do
      it 'returns a result with the same but possibly changed tv_show' do
        expect(subject.call.object.id).to eq(tv_show.id)
      end

      it 'calls appropriate updater' do
        expect(updater).to receive(:call)

        subject.call
      end
    end

    context 'admin' do
      let(:current_user) { build_stubbed(:admin) }
      let(:params) { { tv_show: attributes_for(:tv_show) } }

      before do
        allow(TvShows::Internal::AdminUpdater).to receive(:new).with(
          tv_show, params[:tv_show]
        ).and_return(updater)
      end

      it_behaves_like 'tv_show updater'
    end

    context 'user' do
      let(:current_user) { build_stubbed(:user) }
      let(:watching) { [true, false].sample }
      let(:params) { { tv_show: { watching: watching } } }

      before do
        allow(TvShows::Internal::UserUpdater).to receive(:new).with(
          current_user, tv_show, watching
        ).and_return(updater)
      end

      it_behaves_like 'tv_show updater'

      context 'no :watching in params' do
        let(:params) { { tv_show: {} } }

        it 'fails with parameter missing' do
          expect { subject.call }.to raise_error(ActionController::ParameterMissing)
        end
      end
    end
  end
end
