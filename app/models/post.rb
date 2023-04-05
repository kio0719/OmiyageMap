class Post < ApplicationRecord

  belongs_to :user
  has_one_attached :image

  validates :name, presence: true, length: {maximum: 20}
  validates :place, presence: true 
  validates :caption, presence: true, length:{maximum: 500}
  validates :image, presence: true
end
