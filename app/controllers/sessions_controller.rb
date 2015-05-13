class SessionsController < ApplicationController


  def new
  end

  def create
    @user = User.authenticate(params[:user][:email], params[:user][:password])

    if @user
      session[:user_id] = @user.id
      redirect_to classgroups_path
    else
      flash[:danger] = "Credentials Invalid. Please check your email and password and try again."
      redirect_to :root
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = "You are now logged out."
    redirect_to :root
  end

end