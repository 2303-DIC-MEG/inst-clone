class PicturesController < ApplicationController
  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    Picture.create(picture_params)
    redirect_to new_picture_path
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def picture_params
    params.require(:picture).permit(:image, :content)
  end
end
