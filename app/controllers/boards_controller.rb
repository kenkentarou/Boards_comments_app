class BoardsController < ApplicationController
  before_action :set_board, only: %i[edit update destroy]

  def index
    @search = Board.ransack(params[:q])
    @boards = @search.result(distinct: true).includes(:users).order(created_at: :desc).page(params[:page])
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to(boards_path, success: '投稿の作成が完了しました')
    else
      flash.now[:danger] = '投稿を作成できませんでした'
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).all.order(created_at: :desc)
    @user = User.find(@board.user_id)
  end

  def edit; end

  def update
    if @board.update(board_params)
      redirect_to @board, success: '投稿を更新しました'
    else
      flash.now[:danger] = '投稿を更新できませんでした'
      render :edit
    end
  end

  def destroy
    @board.destroy!
    redirect_to(boards_path, success: '投稿を削除しました')
  end

  def bookmarks
    @search = current_user.bookmark_boards.ransack(params[:q])
    @bookmark_boards = @search.result(distinct: true).includes(:users).order(created_at: :desc).page(params[:page])
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache, :identifier)
  end

  def set_board
    @board = current_user.boards.find(params[:id])
  end
end
