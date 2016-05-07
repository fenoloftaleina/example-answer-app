class AddWatchedToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :watched, :boolean
  end
end
