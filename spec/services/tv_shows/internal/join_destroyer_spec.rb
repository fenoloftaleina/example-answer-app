require 'rails_helper'

describe TvShows::Internal::JoinDestroyer do
  it 'destroys all relations with users for a specific tv show' do
    tv_show_id = create(:user_tv_show).tv_show_id

    TvShows::Internal::JoinDestroyer.new(tv_show_id).call

    expect(UserTvShow.any?).to eq(false)
  end
end
