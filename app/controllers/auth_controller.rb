class AuthController < ApplicationController

  def callback
    provider_user = request.env['omniauth.auth']
    render json: provider_user

    ### NOTES
      #find create a user
      # user = User.find_or_create_by(provider_id: provider_user['uid'], provider: params[:provider]) do |u|
      #   u.provider_hash = provider_user['credentials']['token']
      #   u.name = provider_user['info']['name']
      #   u.email = provider_user['info']['email']
      # end

      # #create user session
      # session[:user_id] = user.id

      # #send them home
      # redirect_to root_path

    # Add Google credentials to user
    # @current_user.provider = params[:provider]
    # @current_user.provider_id = provider_user['uid']
    # @current_user.provider_hash = provider_user['credentials']['token']
    # @current_user.save

  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  def failure
    #TODO: display error page
    render plain: "this is a failure"
  end

end
