class UsersController < ApplicationController


  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.errors.any?
      render :new
    else

      redirect_to classgroups_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    User.update(@user, user_params)
    @user.save
    redirect_to user_path
  end


  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:phone_number)
  end

end

