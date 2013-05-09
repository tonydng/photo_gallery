class Gallery < ActiveRecord::Base
  attr_accessible :name, :description
  validates :name, presence: true
  has_many :photos, dependent: :delete_all
  belongs_to :user
end
