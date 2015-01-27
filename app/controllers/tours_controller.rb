class ToursController < ApplicationController
  before_action :set_nav_active
  before_action :set_tour, only: [:show, :edit, :update, :destroy]

  # GET /tours
  def index
    @tours = Tour.all
  end

  # GET /tours/seluser
  def seluser
    redirect_to action: :index unless params[:tour]
    @tour = Tour.find_by_id(params[:tour])
  end

  # GET /tours/1
  def show
  end

  # GET /tours/new
  def new
    @tour = Tour.new
  end

  # GET /tours/1/edit
  def edit
  end

  # POST /tours
  def create
    @tour = Tour.new(tour_params)
    if @tour.save
      redirect_to action: :index, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tours/1
  def update
    if @tour.update(tour_params)
      redirect_to action: :index, notice: 'Tour was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tours/1
  def destroy
    @tour.destroy
    redirect_to tours_url, notice: 'Tour was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tour_params
      params.require(:tour).permit(:code, :name, :start_date, :end_date, :participant_num, :store_id)
    end

    def set_nav_active
      @nav_active = "Tour"
    end
end
