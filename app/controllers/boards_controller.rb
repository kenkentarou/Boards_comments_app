class BoardsController < ApplicationController
  before_action :require_login

  def index
    @boards = Board.all.includes(:user)
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.new(board_params)
    if @board.save
      redirect_to(boards_path, success: '掲示板の作成が完了しました')
    else
      flash.now[:danger] = '掲示板を作成できませんでした'
      render :new
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image)
  end
end
