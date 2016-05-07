class CreateUserEpisodes < ActiveRecord::Migration
  def change
    create_table :user_episodes do |t|
      t.integer :user_id
      t.integer :episode_id
      t.boolean :watched

      t.timestamps null: false
    end
  end
end
