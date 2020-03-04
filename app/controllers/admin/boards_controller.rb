class Admin::BoardsController < Admin::AdminController
  before_action :require_login
  before_action :set_board, only: %i[show edit update destroy]

  def index
    @search = Board.ransack(params[:q])
    @boards = @search.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @board.update(board_params)
      redirect_to(admin_board_path(params[:id]), success: '投稿を更新しました')
    else
      flash.now[:danger] = '投稿を更新できませんでした'
      render :edit
    end
  end

  def destroy
    @board.destroy!
    redirect_to(admin_boards_path, success: '投稿を削除しました')
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end

  def set_board
    @board = Board.find(params[:id])
  end
end
