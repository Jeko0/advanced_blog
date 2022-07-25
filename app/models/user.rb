class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
         
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :phones, dependent: :destroy
  has_many :locations, dependent: :destroy

  mount_uploader :avatar, AvatarUploader
  
  def set_default_role
    self.role ||= :user
  end
end
