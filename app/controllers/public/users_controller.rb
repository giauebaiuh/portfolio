class Public::UsersController < ApplicationController
  before_action :is_matching_login_user,only:[:edit, :update]

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page])
    @post_comments = @user.post_comments
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :user_comment)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end

end
