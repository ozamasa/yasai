class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authorize, :unless => :except_cond?

private
  def except_cond?
    self.controller_name == 'users'
    #self.controller_name == 'tours' # || self.controller_name == 'items'
  end

  def authorize
    uid = session[:user_id] || params[:user]
    @app_user = User.find(uid) if uid

  	sid = session[:store_id] || params[:store]
  	@app_store = Store.find(sid) if sid

    tid = session[:tour_id] || params[:tour]
    @app_tour = Tour.find(tid) if tid

    create_session
  end

  def create_session
  	unless session[:user_id]
      session[:user_id] = @app_user.id if @app_user
   	end
   	unless session[:store_id]
      session[:store_id] = @app_store.id if @app_store
    end
    unless session[:tour_id]
      session[:tour_id] = @app_tour.id if @app_tour
    end
  end

  def clear_session
    session[:user_id] = nil
    session[:store_id] = nil
    session[:tour_id] = nil
    @app_user = nil
    @app_store = nil
    @app_tour = nil
    reset_session
  end

end
