class BasketsController < ApplicationController
#  before_action :set_tour, only: [:index, :destroy, :order]
#  before_action :set_user, only: [:index, :destroy, :order]
  before_action :set_basket, only: [:destroy]

  # GET /baskets
  def index
    @participant = params[:participant]
    @baskets = Basket.joins(:item).where(tour_code: @app_tour.code, user_id: @participant)
  end

  def order
    ActiveRecord::Base.transaction do

      @participant = params[:participant]
      @baskets = Basket.joins(:item).where(tour_code: @app_tour.code, user_id: @participant)
      raise if @baskets.blank?

      @order = Order.new
      @order.tour_id    = @app_tour.id
      @order.user_id    = @participant
      
      amount = 0
      @baskets.each do |basket|
        order_item = @order.order_items.build
        order_item.item_id  = basket.item_id
        order_item.number   = basket.number
        order_item.price    = basket.item.price
        amount += (order_item.number * order_item.price)
      end

      @order.amount     = amount
      @order.save!

      @baskets.destroy_all
    end

    redirect_to "/orders/#{@order.id}/complete"

  rescue => e
    #logger.info e.message
    #logger.info e.backtrace.join("\n")
    render :index
  end

  # GET /baskets/1
  def show
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
    @participant = params[:participant]
    @basket.destroy
    redirect_to baskets_url(tour: @app_tour.code, participant: @participant), notice: 'Basket was successfully destroyed.'
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
