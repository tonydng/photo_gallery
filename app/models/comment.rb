class Comment < ActiveRecord::Base
	attr_accessible :content
	validates :content, presence: true
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  after_create :creator_watches_photo

  def creator_watches_photo
  	commentable.watchers << user
  end
end
