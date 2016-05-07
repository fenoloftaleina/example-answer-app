class TvShow < ActiveRecord::Base
  has_many :episodes

  has_many :user_tv_shows
  has_many :users, through: :user_tv_shows

  validates_presence_of :title
end
