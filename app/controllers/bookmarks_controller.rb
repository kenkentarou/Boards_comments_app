class BookmarksController < ApplicationController
  def create
    board = Board.find(params[:board_id])
    current_user.like(board)
    respond_to do |format|
      format.js { render template: 'bookmarks/create', locals: {board: board} }
    end
  end

  def destroy
    board = Board.find(params[:id])
    current_user.unlike(board)
    respond_to do |format|
      format.js { render template: 'bookmarks/destroy', locals: {board: board} }
    end
  end
end
