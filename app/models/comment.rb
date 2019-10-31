class Comment < ApplicationRecord
  belongs_to :board
  belongs_to :user
  validates :body, presence: true, length: {maximum: 65_535}
  validates :board_id, presence: true
  validates :user_id, presence: true
end
