class Photo < ActiveRecord::Base
  # attr_accessible :image, :name
  belongs_to :gallery
  belongs_to :user
  has_many :comments
  accepts_nested_attributes_for :comments
  
  validates :name, presence: true
  mount_uploader :image, ImageUploader
end
