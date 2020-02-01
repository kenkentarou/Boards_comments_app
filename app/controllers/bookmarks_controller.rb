class BookmarksController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    current_user.bookmark(@board)
  end

  def destroy
    @board = Board.find(params[:id])
    current_user.unbookmark(@board)
  end
end
