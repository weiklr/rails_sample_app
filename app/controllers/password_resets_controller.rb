class PasswordResetsController < ApplicationController
  before_action :get_user,         only: %i[edit update]
  before_action :valid_user,       only: %i[edit update]
  # have to put at the last, since we need to get_user and valid_user to run first to have a valid user to check against
  before_action :check_expiration, only: %i[edit update] # Case (1) checks for expired password reset requests

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'Email sent with password reset instructions'
      redirect_to root_url
    else
      flash.now[:danger] = 'Email address not found'
      render 'new'
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty? # Case (3)
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update(user_params)
      # clears current sessions in case of session hi-jacking incidents, # Case (4)
      @user.forget
      reset_session
      log_in @user
      # clears reset_digest to prevent public users from click 'back' to reset the password
      @user.update_attribute(:reset_digest, nil)

      flash[:success] = 'Password has been reset.'
      redirect_to @user
    else # Case (2) if password is wrong, defaults to edit page
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless @user && @user.activated? &&
           @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  # Checks expiration of reset token.
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = 'Password reset has expired.'
      redirect_to new_password_reset_url
    end
  end
end
