class Picture < ApplicationRecord
  validates :picture,  presence: true
  validates :content, presence: true, length: { maximum: 255 }
  belongs_to :user
  mount_uploader :picture, ImageUploader
  has_many :favorites, dependent: :destroy
end
