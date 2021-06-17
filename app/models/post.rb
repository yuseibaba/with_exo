class Post < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum:255 }
  
  mount_uploader :post_image, PostImageUploader
end
