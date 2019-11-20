class BookmarksController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    current_user.like(@board)
  end

  def destroy
    @board = Board.find(params[:id])
    current_user.unlike(@board)
  end
end
