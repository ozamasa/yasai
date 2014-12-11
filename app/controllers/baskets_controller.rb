class BasketsController < ApplicationController
  before_action :set_tour, only: [:index, :user, :destroy]
  before_action :set_user, only: [:index, :destroy]
  before_action :set_basket, only: [:show, :edit, :update, :destroy]

  # GET /baskets
  def index
    @baskets = Basket.joins(:item).where(user_id: 1)
  end

  # GET /baskets/1
  def show
  end

  # GET /baskets/user
  def user
  end

  # GET /baskets/new
  def new
    @basket = Basket.new
  end

  # GET /baskets/1/edit
  def edit
  end

  # POST /baskets
  def create
    @basket = Basket.new(basket_params)

    if @basket.save
      redirect_to @basket, notice: 'Basket was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /baskets/1
  def update
    if @basket.update(basket_params)
      redirect_to @basket, notice: 'Basket was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /baskets/1
  def destroy
    @basket.destroy
    redirect_to baskets_url(tour: @tour_code, user_id: @user_id), notice: 'Basket was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_basket
      @basket = Basket.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def basket_params
      params[:basket]
    end

    def set_tour
      unless @tour_code
        redirect_to '/tours' if params[:tour].blank?
        @tour_code = params[:tour]
      end
    end

    def set_user
      unless @user_id
        redirect_to action: :user, tour: @tour_code if params[:user_id].blank?
        @user_id = params[:user_id]
      end
    end
end
