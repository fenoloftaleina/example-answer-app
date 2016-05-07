class CreateUserTvShows < ActiveRecord::Migration
  def change
    create_table :user_tv_shows do |t|
      t.integer :user_id
      t.integer :tv_show_id

      t.timestamps null: false
    end
  end
end
