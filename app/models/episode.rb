class Episode < ActiveRecord::Base
  belongs_to :tv_show, touch: true

  has_many :user_episodes

  has_many :user_episodes_for_user_tv_shows, -> do
    where('user_episodes.user_id = user_tv_shows.user_id')
  end, class_name: UserEpisode

  has_many :users_that_watched, -> { where(user_episodes: { watched: true }) },
    source: :user, through: :user_episodes
end
