class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    
    if @user && @user.authenticate(params[:session][:password])
      # login
      # prevents sesssion fixation attacks by reseting the session id
      reset_session
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      cookies['simple'] = "TEST!!!!"
      log_in @user
      redirect_to @user

    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
