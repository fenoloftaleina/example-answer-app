require 'rails_helper'

describe Episodes::Internal::JoinDestroyer do
  it 'destroys all relations with users for a specific tv show' do
    episode_id = create(:user_episode).episode_id

    Episodes::Internal::JoinDestroyer.new(episode_id).call

    expect(UserEpisode.any?).to eq(false)
  end
end
