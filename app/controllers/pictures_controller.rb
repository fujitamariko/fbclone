class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]

  # GET /pictures or /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1 or /pictures/1.json
  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  # GET /pictures/new
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures or /pictures.json
  # user_idとimageは後で書き足す
  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    else
      if @picture.save
        redirect_to new_picture_path
      else
        render :new
      end
    end
  end

  # PATCH/PUT /pictures/1 or /pictures/1.json
  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "ブログを編集しました！"
    else
      render :edit
    end
  end

  # DELETE /pictures/1 or /pictures/1.json
  def destroy
    @picture.destroy
    redirect_to pictures_path, notice:"ブログを削除しました！"
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def picture_params
      params.require(:picture).permit(:title, :content, :image, :image_cache)
    end
end
