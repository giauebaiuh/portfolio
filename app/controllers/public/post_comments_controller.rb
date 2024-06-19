class Public::PostCommentsController < ApplicationController
  before_action :is_matching_login_user
  def create
    post_image = PostImage.find(params[:post_image_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_image_id = post_image.id
    comment.save
    redirect_to post_image_path(post_image)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to user_path(current_user)
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:body)
  end

  def is_matching_login_user
    post_comment = PostComment.find(params[:id])
    unless post_comment.user.id == current_user.id
      redirect_to post_image_path
    end
  end

end