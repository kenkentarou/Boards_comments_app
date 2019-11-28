class BoardsController < ApplicationController
  before_action :require_login
  before_action :set_board, only: %i[edit update destroy]

  def index
    @boards = Board.all.includes(:user).page(params[:page])
    @search = Board.ransack(params[:q])
    @boards = @search.result(distinct: true).page(params[:page])
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to(boards_path, success: '掲示板の作成が完了しました')
    else
      flash.now[:danger] = '掲示板を作成できませんでした'
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).all.order(created_at: :desc)
  end

  def edit; end

  def update
    if @board.update(board_params)
      redirect_to(board_path(params[:id]), success: '掲示板を更新しました')
    else
      flash.now[:danger] = '掲示板を更新できませんでした'
      render :edit
    end
  end

  def destroy
    @board.destroy!
    redirect_to(boards_path, success: '掲示板を削除しました')
  end

  def bookmarks
    @bookmark_boards = current_user.bookmark_boards
    @search = Board.ransack(params[:q])
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image)
  end

  def set_board
    @board = current_user.boards.find(params[:id])
  end
end
