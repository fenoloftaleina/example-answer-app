class UserTvShow < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :tv_show, touch: true

  validates_uniqueness_of :user_id, :scope => :tv_show_id
end
