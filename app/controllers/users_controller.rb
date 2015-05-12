class UsersController < ApplicationController

  before_action :is_authenticated?, except: [:create, :new]

  def check_email
    render :json => params
    # @user = User.find_by_email(params)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @user = User.authenticate(params[:user][:email], params[:user][:password])
    if @user
      session[:user_id] = @user.id
      redirect_to classgroups_path
    else
      flash[:danger] = "Credentials Invalid"
      render :new
    end

  end

  def show
    @user = User.find(@current_user)
  end

  def edit
    @user = User.find(@current_user)
  end

  def update
    @user = User.find(@current_user)
    User.update(@user, user_params)
    @user.save
    redirect_to user_path
  end


  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:phone_number)
  end

end

