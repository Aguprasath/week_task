class UserCommentRatingsController < ApplicationController
  before_action :set_user_comment_rating
  def new
    @user = current_user
    @comment = Comment.find(params[:comment_id])

  end

  def create
    @user_comment_rating = UserCommentRating.new(user_comment_rating_params)
    if @user_comment_rating.save
      #format.turbo_stream{redirect_to topic_post_comments_path(@post.topic,@post),notice: "Rating added to comment"}
    else
      render :new
    end
  end

  def view_ratings
    @comment = Comment.find(params[:comment_id])
    @user_ratings = @comment.user_comment_ratings.includes(:user)
  end

  private
  def set_user_comment_rating
    @user_comment_rating=UserCommentRating.new
  end
  def user_comment_rating_params
    params.require(:user_comment_rating).permit(:user_id, :comment_id, :rating)
  end
end