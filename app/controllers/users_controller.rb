class UsersController < ApplicationController
  def show
    # use params to retrieve id
    @user = User.find(params[:id])
  end
  
  def new
    
  end
end
