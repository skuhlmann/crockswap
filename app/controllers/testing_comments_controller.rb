class TestingCommentsController < ApplicationController

  def new
    @testing_comment = TestingComment.new
  end

  def create
    @testing_comment = TestingComment.new(comments_params)
    if @testing_comment.save
      redirect_to new_testing_comment_path, alert: "Thank you"
    else
      flash[:alert] = "Comments are required."
      render :new
    end
  end

  def comments_params
    params.require(:testing_comment).permit(:email, :name, :comments)
  end
end