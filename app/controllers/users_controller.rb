class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_nav_active

  # GET /producers
  def index
    @users = User.all
  end

  # GET /producers/1
  def show
  end

  # GET /producers/new
  def new
    @user = User.new
  end

  # GET /producers/1/edit
  def edit
  end

  # POST /producers
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /producers/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Producer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /producers/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :name_kana, :address, :tel)
    end

    def set_nav_active
      @nav_active = "User"
    end    
end
