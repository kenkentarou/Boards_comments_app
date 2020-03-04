class Board < ApplicationRecord
  mount_uploader :board_image, ImageUploader
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks
  belongs_to :user
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :identifier, length: { maximum: 200 }

  def split_id_from_youtube_url
    identifier.split('/').last
  end
end
