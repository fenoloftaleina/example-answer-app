class RemoveUserIdFromTvShows < ActiveRecord::Migration
  def change
    remove_column :tv_shows, :user_id
  end
end
