class CultivarsController < ApplicationController
  before_action :set_cultivar, only: [:show, :edit, :update, :destroy]
  before_action :set_nav_active

  # GET /cultivars
  def index
    @cultivars = Cultivar.all
  end

  # GET /cultivars/1
  def show
  end

  # GET /cultivars/new
  def new
    @cultivar = Cultivar.new
  end

  # GET /cultivars/1/edit
  def edit
  end

  # POST /cultivars
  def create
    @cultivar = Cultivar.new(cultivar_params)

    if @cultivar.save
      redirect_to @cultivar, notice: 'Cultivar was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /cultivars/1
  def update
    if @cultivar.update(cultivar_params)
      redirect_to @cultivar, notice: 'Cultivar was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /cultivars/1
  def destroy
    @cultivar.destroy
    redirect_to cultivars_url, notice: 'Cultivar was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cultivar
      @cultivar = Cultivar.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cultivar_params
      params.require(:cultivar).permit(:name, :unit, :category_id)
    end

    def set_nav_active
      @nav_active = "Cultivar"
    end
end
