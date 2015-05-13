class UsersController < ApplicationController

  before_action :is_authenticated?, except: [:create, :new]


  def new
    @new_user = User.new
  end

  # def check_email
  #   @user = User.find_by_email(params[:new_user][:email])
  #   respond_to do |format|
  #     format.json {render :json => !@user}
  #   end
  # end

  def create

    @user = User.find_or_create_by(email: user_params[:email])
    @user = User.authenticate(params[:new_user][:email], params[:new_user][:password])
    if @user
      session[:user_id] = @user.id
      redirect_to classgroups_path
    else
      flash[:danger] = "An account already exists with that email"
      # render :new
      redirect_to '/'
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
    params.require(:new_user).permit(:name,:email,:password,:phone_number)
  end

end

