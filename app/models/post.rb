class Post < ApplicationRecord
  # 画像投稿
  mount_uploader :image, ImageUploader
  
  
  belongs_to :user

  validates :content, presence: true, length: { maximum: 300 }
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites, source: :user

end