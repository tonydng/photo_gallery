class Photo < ActiveRecord::Base
  belongs_to :gallery
  validates :name, presence: true
end
