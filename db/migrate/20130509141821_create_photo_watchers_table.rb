class CreatePhotoWatchersTable < ActiveRecord::Migration
  def change
  	create_table :photo_watchers, id: false do |t|
  		t.integer :user_id, :photo_id
  	end
  end
end
