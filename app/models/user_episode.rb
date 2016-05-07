class UserEpisode < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :episode, touch: true

  validates_uniqueness_of :user_id, :scope => :episode_id
end
