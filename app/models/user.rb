class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name

  validates :name, presence: true, unless: :guest_user?

  has_many :galleries, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  def self.new_guest
    new { |u| u.guest_user = true }
  end

  def to_s
    "#{name} (#{admin? ? "Admin" : "User"})"
  end
end
