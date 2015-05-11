class AuthController < ApplicationController

  before_action :is_authenticated?

  def callback
    provider_user = request.env['omniauth.auth']
    # render json: provider_user

    # Add Google credentials to user
    @current_user.provider = params[:provider]
    @current_user.provider_id = provider_user['uid']
    @current_user.provider_hash = provider_user['credentials']['token']
    @current_user.save

    flash[:info] = "Schedulacity is now connected with your Google account"
    redirect_to events_path

  end

  def logout
    @current_user.provider = nil
    @current_user.provider_id = nil
    @current_user.provider_hash = nil
    @current_user.save

    flash[:info] = "Schedulacity is no longer connected with your Google account"
    redirect_to events_path
  end

  def failure
    #TODO: display error page
    render plain: "this is a failure"
  end

end
