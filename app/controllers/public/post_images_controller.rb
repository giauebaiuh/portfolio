class Public::PostImagesController < ApplicationController
  before_action :is_matching_login_user,only:[:edit, :update]

  def index
    @post_images = PostImage.page(params[:page])
  end

  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      flash[:notice] = "投稿が完了しました。"
      redirect_to post_image_path(@post_image)
    else
      render :new
    end
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def search
    if params[:prefecture] != '---' && params[:genre] != '---'
      @post_images = PostImage.where(prefecture: params[:prefecture]).where(genre: params[:genre]).page(params[:page])
    elsif params[:prefecture] != '---'
      @post_images = PostImage.where(prefecture: params[:prefecture]).page(params[:page])
    elsif params[:genre] != '---'
      @post_images = PostImage.where(genre: params[:genre]).page(params[:page])
    else
      @post_images = PostImage.page(params[:page])
    end
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    @post_image = PostImage.find(params[:id])
    if @post_image.update(post_image_params)
      flash[:notice] = "編集が完了しました。"
      redirect_to  post_image_path
    else
      render :edit
    end
  end

  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to user_path(post_image.user.id)
  end

  private

  def post_image_params
    params.require(:post_image).permit(:trade_name,:caption,:image, :genre, :prefecture, :star)
  end

  def is_matching_login_user
    post_image = PostImage.find(params[:id])
    unless post_image.user.id == current_user.id
      redirect_to post_images_path
    end
  end

end
