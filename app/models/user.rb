class User < ApplicationRecord
  mount_uploader :user_image, AvatarUploader
  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_boards, through: :bookmarks, source: :board
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  authenticates_with_sorcery!
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: { scope: :reset_password_token }

  enum role: {general: 0,
              admin: 1}

  def own_board?(board)
    id == board.user_id
  end

  def like(board)
    bookmarks.find_or_create_by(board_id: board.id)
  end

  def unlike(board)
    bookmark = bookmarks.find_by(board_id: board.id)
    bookmark&.destroy
  end

  def bookmark_board?(board)
    bookmark_boards.include?(board)
  end
end
