class AddUserToTvShow < ActiveRecord::Migration
  def change
    add_column :tv_shows, :user_id, :integer
  end
end
