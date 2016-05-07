require 'rails_helper'

describe UserTvShow do
  let(:user_id) { 1 }

  it 'validates uniqueness of the user_id, tv_show_id pair' do
    first_user_pair = create(:user_tv_show, user_id: user_id, tv_show_id: 1)
    second_user_pair = build_stubbed(:user_tv_show, user_id: user_id, tv_show_id: 1)

    expect(second_user_pair.valid?).to eq(false)
  end
end
