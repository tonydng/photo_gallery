class Gallery < ActiveRecord::Base
  # attr_accessible :name
  validates :name, presence: true
  has_many :photos, dependent: :delete_all
end
