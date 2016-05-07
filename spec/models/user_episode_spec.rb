require 'rails_helper'

describe UserEpisode do
  let(:user_id) { 1 }

  it 'validates uniqueness of the user_id, episode_id pair' do
    first_user_pair = create(:user_episode)
    second_user_pair = build_stubbed(
      :user_episode, user_id: first_user_pair.user_id,
      episode_id: first_user_pair.episode_id
    )

    expect(second_user_pair.valid?).to eq(false)
  end
end
