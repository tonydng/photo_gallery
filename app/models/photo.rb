class Photo < ActiveRecord::Base
  attr_accessible :image, :name
  after_create :creator_watches_me

  belongs_to :gallery
  belongs_to :user
  has_many :comments, as: :commentable
  has_and_belongs_to_many :watchers, join_table: "photo_watchers",
  																		class_name: "User"
  

  validates :name, presence: true
  mount_uploader :image, ImageUploader

  def creator_watches_me
  	if !self.watchers.include?(user) 
  		self.watchers << user if user
  	end
  end
end
