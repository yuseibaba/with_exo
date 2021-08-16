class User < ApplicationRecord
  before_save { self.email.downcase! } 
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false } 
  validates :introduce_comment, length: { maximum: 255 }
  
  has_secure_password
  mount_uploader :image, ImageUploader
  
  has_many :posts, dependent: :destroy
  
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :post

  has_many :comments, dependent: :destroy
  has_many :remarks, through: :comments, source: :post
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end

  def feed_posts
    Post.where(user_id: following_ids + [self.id])
  end
  
  def like(post)
    self.favorites.find_or_create_by(user_id: self.id, post_id: post.id)
  end

  def unlike(post)
    favorite = self.favorites.find_by(user_id: self.id, post_id: post.id)
    favorite.destroy if favorite
  end
  
  def liking?(post)
    self.likes.include?(post)
  end

  def self.guest
    find_or_create_by!(name: 'ゲスト') do |user|
      user.assign_attributes({
        email: 'guest@example.jp',
      })
      user.password_digest = SecureRandom.urlsafe_base64
    end
  end

end