class Post < ActiveRecord::Base
  extend Geocoder::Model::ActiveRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  
  belongs_to :user
  has_many_attached :images, dependent: :destroy
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  validates :address, presence: true
  validates :caption, presence: true, length: { maximum: 500 }

  ransacker :likes_count do
    query = '(SELECT COUNT(likes.post_id) FROM likes where likes.post_id = posts.id GROUP BY likes.post_id)'
    Arel.sql(query)
  end
end
