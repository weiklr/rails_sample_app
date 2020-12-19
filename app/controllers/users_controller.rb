class UsersController < ApplicationController
  def show
    # use params to retrieve id
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      # login in new users by default
      log_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else 
      render 'new'
    end
  end

  private
    def user_params
          params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
    end
end
