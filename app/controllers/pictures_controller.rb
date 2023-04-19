class PicturesController < ApplicationController
  before_action :set_picture, only: [:edit, :update, :show, :destroy]
  before_action :ensure_current_user_edit_posted_picture, only: [:edit, :update]


  def index
    @pictures = Picture.all
    @users = User.all
    @favorites = Favorite.all.where(user_id: current_user.id)
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    else
      if @picture.save
        PictureMailer.contact_mail(@picture).deliver
        redirect_to pictures_path
      else
        render :new
      end
    end
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def edit
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "ブログを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path, notice:"削除しました"
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  def bookmarks
    @pictures = current_user.favorites
  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:picture, :content, :picture_cache)
  end

  def ensure_current_user_edit_posted_picture
    @picture = Picture.find(params[:id])
    if @current_user.id != @picture.user_id
      flash[:notice]="権限がありません"
      redirect_to pictures_path
    end
  end
end
