class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :pictures
  validates_uniqueness_of :pictures_id, scope: :user_id
end
