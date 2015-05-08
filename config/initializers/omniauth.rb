Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']
  # provider :twitter, ENV['TWITTER_APP_ID'], ENV['TWITTER_APP_SECRET']
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    access_type: 'offline',
    # scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar',
    scope: 'userinfo.email calendar',
    redirect_uri:'http://localhost:3000/auth/google_oauth2/callback'
  }
end
