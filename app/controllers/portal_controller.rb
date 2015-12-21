class PortalController < ApplicationController

  # GET /portal
  def index
  	clear_session
  	@users = User.all
  	@stores = Store.all
  	render :layout => false
  end

end
