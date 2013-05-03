class Photo < ActiveRecord::Base
  belongs_to :gallery
  validates :name, presence: true
  mount_uploader :image, ImageUploader
end
