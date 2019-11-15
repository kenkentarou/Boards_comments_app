class User < ApplicationRecord
  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarks_boards, through: :bookmarks, source: :board
  authenticates_with_sorcery!
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true

  def own_board?(board)
    id == board.user_id
  end

  def like(board)
    bookmarks.find_or_create_by(board_id: board.id)
  end

  def unlike(board)
    bookmark = bookmarks.find_by(board_id: board.id)
    bookmark.destroy if bookmark
  end

  def bookmarks_board?(board)
    bookmarks_boards.include?(board)
  end
end
