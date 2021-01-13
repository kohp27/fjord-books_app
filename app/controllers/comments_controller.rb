# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_parent, only: :create

  def create
    comment = @parent.comments.build(comment_params)

    if comment.save
      redirect_to @parent, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to @parent
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to comment.commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_parent
    @parent =
      if params[:book_id]
        Book.find(params[:book_id])
      elsif params[:report_id]
        Report.find(params[:report_id])
      end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
