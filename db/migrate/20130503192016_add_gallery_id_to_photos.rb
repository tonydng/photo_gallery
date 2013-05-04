class AddGalleryIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :gallery_id, :integer
    add_index :photos, :gallery_id
  end
end
