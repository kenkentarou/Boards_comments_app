class BookmarksController < ApplicationController
  def create
    board = Board.find(params[:board_id])
    if current_user.like(board)
      flash[:success] = 'お気に入り登録をしました。'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'お気に入り失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    board = Board.find(params[:id])
    current_user.unlike(board)
    flash[:success] = 'お気に入り登録を解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
