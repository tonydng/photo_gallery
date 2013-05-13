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
  attr_accessible :name, :email, :password, :admin, as: :admin

  validates :name, presence: true

  has_many :galleries, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  def to_s
    "#{name} <#{email}> (#{admin? ? "Admin" : "User"})"
  end
end
