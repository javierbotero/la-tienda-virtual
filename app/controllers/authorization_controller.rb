class AuthorizationController < ApplicationController
  skip_before_action :authorize_user, except: [:logout, :destroy]

  def login; end

  def login_user
    @user = User.find_by(user_params)

    if @user.present?
      session[:user_id] = @user.id
      redirect_to :root
    else
      flash.now[:error] = "Invalid credentials"
      render :login
    end
  end

  def logout; end

  def destroy
    session.delete(:user_id)
    @current_user = nil

    redirect_to login_url, notice: 'User logged out'
  end

  def register; end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to :root, notice: "User was successfully registered"
    else
      flash.now[:error] = "Invalid credentials"
      render :register
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
