class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_tv_shows
  has_many :tv_shows, through: :user_tv_shows

  has_many :user_episodes
  has_many :watched_episodes, -> { where(user_episodes: { watched: true }) },
    source: :episode, through: :user_episodes
end
