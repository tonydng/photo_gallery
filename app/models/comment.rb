class Comment < ActiveRecord::Base
  # attr_accessible :content, :photo_id, :user_id
  belongs_to :user
  validates :content, presence: true
end
