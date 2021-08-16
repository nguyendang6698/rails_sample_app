class SessionsController < ApplicationController
  
  def new    
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in(@user)
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        message = "Tai khoan chua kich hoat."
        message += "\nKiem tra link kich hoat duoc gui den email cua ban."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Email/password khong chinh xac!"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
    # byebug
  end
end
