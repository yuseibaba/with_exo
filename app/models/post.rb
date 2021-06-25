class Post < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum:255 }
  
  mount_uploader :post_image, PostImageUploader
  
  has_many :favorites, dependent: :destroy
  has_many :liked, through: :favorites, source: :user
end
