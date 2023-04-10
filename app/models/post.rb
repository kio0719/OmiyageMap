class Post < ApplicationRecord

  belongs_to :user
  has_one_attached :image, dependent: :destroy
  has_many :likes, -> {order(created_at: :desc)}, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: {maximum: 20}
  validates :address, presence: true 
  validates :caption, presence: true, length:{maximum: 500}
  validates :image, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
