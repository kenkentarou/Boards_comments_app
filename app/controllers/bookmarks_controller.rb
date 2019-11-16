class BookmarksController < ApplicationController
  def create
    board = Board.find(params[:board_id])
    if current_user.like(board)
      flash[:success] = 'お気に入り登録をしました。'
    else
      flash[:danger] = 'お気に入り失敗しました。'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    board = Board.find(params[:id])
    current_user.unlike(board)
    flash[:success] = 'お気に入り登録を解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
