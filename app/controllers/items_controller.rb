class ItemsController < ApplicationController
  before_action :set_nav_active
  before_action :set_tour, only: [:tour_index, :putin]
  before_action :set_user, only: [:tour_index, :putin]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def tour_index
    @items = Item.all
  end

  # GET /items/1/putin
  def putin
    @item = Item.find(params[:id])
    @basket = Basket.new
    @basket.tour_code = @tour_code
    @basket.user_id   = @user_id
    @basket.item_id   = @item.id
    @basket.number    = params[:num]
    @basket.save!
    redirect_to controller: :baskets, action: :index, tour: @tour_code, user_id: @user_id
  rescue
      render :index
  end

  # GET /items
  def index
    @items = Item.all
  end

  # GET /items/1
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  def create

    FileUtils.mkdir_p(Constants::ROOT_DIR) unless FileTest.exist?(Constants::ROOT_DIR)

    imgfile = item_params[:image_path]
    upload_path = Constants::ROOT_DIR + imgfile.original_filename
    File.open(upload_path, 'wb') { |f| f.write(imgfile.read) }

    @item = Item.new
    @item.code          = item_params[:code]
    @item.name          = item_params[:name]
    @item.price         = item_params[:price]
    @item.description   = item_params[:description]
    @item.producer_id   = item_params[:producer_id]
    @item.harvested_at  = item_params[:harvested_at]
    @item.image_path    = imgfile.original_filename

    if @item.save
      redirect_to @item, notice: '商品情報を登録しました.'
    else
      render :new
    end
  end

  # PATCH/PUT /items/1
  def update

    FileUtils.mkdir_p(Constants::ROOT_DIR) unless FileTest.exist?(Constants::ROOT_DIR)

    if @item.image_path
      delete_path = Constants::ROOT_DIR + @item.image_path
      File.delete(delete_path) if FileTest.exist?(delete_path)
    end

    imgfile = item_params[:image_path]
    upload_path = Constants::ROOT_DIR + imgfile.original_filename
    File.open(upload_path, 'wb') { |f| f.write(imgfile.read) }

    @item.code          = item_params[:code]
    @item.name          = item_params[:name]
    @item.price         = item_params[:price]
    @item.description   = item_params[:description]
    @item.producer_id   = item_params[:producer_id]
    @item.harvested_at  = item_params[:harvested_at]
    @item.image_path    = imgfile.original_filename

    if @item.save
      redirect_to @item, notice: '商品情報を更新しました.'
    else
      render :edit
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
    redirect_to items_url #, notice: 'Item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params[:item]
    end

    def set_tour
      redirect_to '/tours' if params[:tour].blank?
      @tour_code = params[:tour]
      @tour = Tour.find_by_code(params[:tour])
    end

    def set_user
      redirect_to "/tours/#{@tour_code}/user" if params[:user_id].blank?
      @user_id = params[:user_id]
    end

    def set_nav_active
      @nav_active = "Item"
    end
end
