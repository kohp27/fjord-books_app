# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_parent

  def create
    comment = @parent.comments.build(comment_params)

    if comment.save
      redirect_to @parent, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to @parent
    end
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
