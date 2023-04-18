class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  validates :password, length: { minimum: 6 }
  mount_uploader :image, ImageUploader
  has_secure_password
  has_many :pictures
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
end