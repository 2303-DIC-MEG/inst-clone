class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :ensure_current_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @pictures = @user.pictures

    favorites = Favorite.where(user_id: current_user.id).pluck(:picture_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
    @favorite_list = Picture.find(favorites)     # postsテーブルから、お気に入り登録済みのレコードを取得
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to new_session_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: '更新しました。'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end

  def ensure_current_user
    if @current_user.id != params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to new_session_path
    end
  end
end
