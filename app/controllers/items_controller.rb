class ItemsController < ApplicationController
  before_action :set_nav_active
#  before_action :set_tour, only: [:shopping_index, :putin]
  before_action :set_user, only: [:shopping_index, :putin]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def shopping_index
    @items = Item.all
  end

  # GET /items/1/putin
  def putin
    @item = Item.find(params[:id])
    @basket = Basket.new
    @basket.tour_code = @app_tour.code
    @basket.user_id   = params[:participant]
    @basket.item_id   = @item.id
    @basket.number    = params[:num]
    @basket.save!
    redirect_to controller: :baskets, action: :index, tour: @app_tour.code, participant: params[:participant]
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

    @item = Item.new(item_params)
    if imgfile
      upload_path = Constants::ROOT_DIR + imgfile.original_filename
      File.open(upload_path, 'wb') { |f| f.write(imgfile.read) }
      @item.image_path    = imgfile.original_filename
    end

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

    @item.attributes = item_params
    if imgfile
      upload_path = Constants::ROOT_DIR + imgfile.original_filename
      File.open(upload_path, 'wb') { |f| f.write(imgfile.read) }
      @item.image_path    = imgfile.original_filename
    end

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
      params.require(:item).permit(:code, :cultivar_id, :name, :price, :description, :image_path, :producer_id, :cultivar_id, :harvested_at, :unit)      
    end

    def set_tour
      redirect_to '/tours' if params[:tour].blank?
      @tour = Tour.find(params[:tour]) rescue nil
    end

    def set_user
      redirect_to "/tours/#{@app_tour.id}/seluser" if params[:participant].blank?
      @participant = params[:participant]
    end

    def set_nav_active
      redirect_to '/tours' unless @app_tour
      @nav_active = "Item"
    end
end
