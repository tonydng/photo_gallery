class Gallery < ActiveRecord::Base
  # attr_accessible :description, :name
  validates :name, presence: true
  has_many :photos, dependent: :delete_all
end
