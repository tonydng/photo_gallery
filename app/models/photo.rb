class Photo < ActiveRecord::Base
  # attr_accessible :image, :name
  belongs_to :gallery
  belongs_to :user
  validates :name, presence: true
  mount_uploader :image, ImageUploader
end
