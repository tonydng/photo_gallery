class Gallery < ActiveRecord::Base
  attr_accessible :name, :description
  validates :name, presence: true
  has_many :photos, dependent: :destroy
  belongs_to :user
end
