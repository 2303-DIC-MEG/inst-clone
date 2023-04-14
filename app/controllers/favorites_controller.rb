class FavoritesController < ApplicationController
  before_action :set_picture
  before_action :authenticate_user!   # ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）

  # お気に入り登録
  def create
    if @picture.user_id != current_user.id   # 投稿者本人以外に限定
      @favorite = Favorite.create(user_id: current_user.id, picture_id: @picture.id)
    end
  end
  # お気に入り削除
  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, picture_id: @picture.id)
    @favorite.destroy
  end

  private
  def set_picture
    @picture = Picture.find(params[:post_id])
  end
end
