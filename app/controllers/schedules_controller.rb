class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:edit, :update, :destroy]
  before_action :set_nav_active

  # GET /schedules
  def index
    redirect_to :root unless @app_store

    @from_date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i) rescue @from_date = Date.today
    @to_date = @from_date + 6.days

    @schedules = {}
    @events = {}
    (@from_date..@to_date).each do |date|

      @schedules[date] = Schedule.find_by_sql(Schedule.sql_sum(date, @app_store.id))

      tbl = Event.arel_table
      conditions = tbl[:store_id].eq(@app_store.id)
      conditions = conditions.and(tbl[:start_at].in(date.beginning_of_day..date.end_of_day).or(
        tbl[:end_at].in(date.beginning_of_day..date.end_of_day)))
      @events[date]     = Event.where(conditions)
    end
  end

  # GET /schedules/2015/1/16/1
  def my_index    
    @from_date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i) rescue @from_date = Date.today
    @to_date = @from_date + 6.days

    @events = {}
    (@from_date..@to_date).each do |date|
      tbl = Event.arel_table
      conditions = tbl[:start_at].in(date.beginning_of_day..date.end_of_day).or(
        tbl[:end_at].in(date.beginning_of_day..date.end_of_day))
      @events[date]     = Event.where(conditions)
    end
  end


  # GET /schedules/show/2015/1/22/1
  def show
    redirect_to :root unless @app_store

    @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i) rescue @from_date = Date.today    
    
    tbl = Schedule.arel_table
    conditions = tbl[:date].eq(@date).and(tbl[:store_id].eq(@app_store.id))
    @schedules = Schedule.where(conditions).group_by(&:cultivar_id)
    @cultivars = Cultivar.all

    @cultivar_sums = {}
    @cultivars.each do |cultivar|
      @cultivar_sums[cultivar.id] = Schedule.find_by_sql(Schedule.sql_sum(@date, @app_store.id, cultivar.id))
    end
  end

  # GET /schedules/new
  def new
    logger.info @app_user.inspect
    @schedule = Schedule.new
    @schedule.date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i) rescue nil
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules
  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.producer_id = @app_user.id
    if @schedule.save
      redirect_to "/myschedule/#{@schedule.date.year}/#{@schedule.date.month}/#{@schedule.date.day}/#{@app_user.id}", notice: 'Schedule was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /schedules/1
  def update
    if @schedule.update(schedule_params)
      redirect_to "/myschedule/#{@schedule.date.year}/#{@schedule.date.month}/#{@schedule.date.day}/#{@app_user.id}", notice: 'Schedule was successfully created.'
    else
      render :edit
    end
  end

  # DELETE /schedules/1
  def destroy
    @schedule.destroy
    redirect_to schedules_url, notice: 'Schedule was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def schedule_params
      #params[:schedule]
      params.require(:schedule).permit(:date, :store_id, :producer_id, :cultivar_id, :amount)
    end

    def set_nav_active
      @nav_active = "Schedule"
    end
end
