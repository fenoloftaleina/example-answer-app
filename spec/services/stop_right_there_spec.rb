require 'rails_helper'

describe StopRightThere do
  subject { StopRightThere }

  describe '#with_permissions' do
    context 'regular user' do
      let(:current_user) { build_stubbed(:user) }

      it 'results in a 403' do
        expect(subject.with_permissions(current_user).status).to eq(403)
      end
    end

    context 'admin' do
      let(:current_user) { build_stubbed(:admin) }

      it 'yields' do
        expect { |b| subject.with_permissions(current_user, &b) }.
          to yield_with_no_args
      end
    end
  end
end
