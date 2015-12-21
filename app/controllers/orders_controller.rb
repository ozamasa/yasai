class OrdersController < ApplicationController
  before_action :set_order, only: [:complete, :show, :edit, :update, :destroy]
  before_action :set_tour, only: [:index, :show, :complete]

  # GET /orders
  def index
    @orders = Order.includes(:order_items).where(tour_id: @tour.id)
  end

  # GET /orders/1/complete
  def complete
  end

  # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'Order was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params[:order]
    end

    def set_tour
      if @order.present?
        @tour = Tour.find(@order.tour_id)
      else
        redirect_to '/tours' if params[:tour].blank?
        @tour_code = params[:tour]
        @tour = Tour.find_by_code(@tour_code)
      end
    end
end
