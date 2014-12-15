class ItemsController < ApplicationController
  before_action :set_tour, only: [:index, :putin]
  before_action :set_user, only: [:index, :putin]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  def index
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
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
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
    end

    def set_user
      redirect_to "/tours/#{@tour_code}/user" if params[:user_id].blank?
      @user_id = params[:user_id]
    end
end
