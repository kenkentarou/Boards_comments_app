class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update(comment_update_params)
      render json: {}
    else
      render json: {}, status: :bad_request
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end
end
