class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes , dependent: :destroy 
  
  validates :title, presence: true
  validates :body, presence: true

  def self.inactive_post 
    Post.all.each do |post| 
      if post.created_at + 10.days < Time.now && post.likes.count.zero? 
        post.update(approved: false)
      end
    end
  end
end
