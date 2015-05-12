class AuthController < ApplicationController

  before_action :is_authenticated?

  def callback
    provider_user = request.env['omniauth.auth']
    # render json: provider_user

    # Add Google credentials to user
    @current_user.provider = params[:provider]
    @current_user.provider_id = provider_user['uid']
    @current_user.provider_hash = provider_user['credentials']['token']
    @current_user.refresh_hash = provider_user['credentials']['refresh_token']
    @current_user.hash_expires_at = Time.at(provider_user['credentials']['expires_at'])

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

# {
#   provider: "google_oauth2",
#   uid: "103937674474000315962",
#   info: {
#     name: "Nicholas Cronquist",
#     email: "ncron23@gmail.com",
#     first_name: "Nicholas",
#     last_name: "Cronquist",
#     image: "https://lh3.googleusercontent.com/-EsCQjQiBPtQ/AAAAAAAAAAI/AAAAAAAAe3g/0_Qmno5aAZE/photo.jpg?sz=50",
#     urls: {
#     Google: "https://plus.google.com/+NicholasCronquist"
#     }
#   },
#   credentials: {
#     token: "ya29.cAHacQQK8ytAqUaL-XJsvaU4RwGZcRQErg1BvlF6QC3NBmsv-WJTV-v_ndzBIW2PWSPGvmx6tPR8ag",
#     refresh_token: "1/uW5R-ehatjY2HexUOgVpbl0ycDXAtgGVroQjIPp7qe4MEudVrK5jSpoR30zcRFq6",
#     expires_at: 1431375672,
#     expires: true
#   },
#   extra: {
#     id_token: "eyJhbGciOiJSUzI1NiIsImtpZCI6IjlhZTRiNzQzOGQ1ODkyYmUxMWJhY2JiMDNlM2FhMjdkNzY1ZjVmYTgifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwic3ViIjoiMTAzOTM3Njc0NDc0MDAwMzE1OTYyIiwiYXpwIjoiNTU3MTcxMjkxNTA1LXBnamllbWgzNzZyYmlyMXVic2V0OW5vNmpnbDdhdmphLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiZW1haWwiOiJuY3JvbjIzQGdtYWlsLmNvbSIsImF0X2hhc2giOiJYTTkxcFpzN0oyakNOS3NWMjViLVFBIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF1ZCI6IjU1NzE3MTI5MTUwNS1wZ2ppZW1oMzc2cmJpcjF1YnNldDlubzZqZ2w3YXZqYS5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImlhdCI6MTQzMTM3MjA3MiwiZXhwIjoxNDMxMzc1NjcyfQ.SV5vNubOFwH1rDt1Cdg0xmDlpI95p82MzRoJInzsCSMP4Inw2oyF8GOQUAuaJz8RCU4Wn4zrroP0jIY31tb2HrKqBkQoBIkfuat4C5MMfWDUbrg5JFS5ioArIlxqP15Dl9ZZR-b4EiXBSWGERiKaS_nBmdKIPqZdcEQotOeB_cM",
#     raw_info: {
#       kind: "plus#personOpenIdConnect",
#       gender: "male",
#       sub: "103937674474000315962",
#       name: "Nicholas Cronquist",
#       given_name: "Nicholas",
#       family_name: "Cronquist",
#       profile: "https://plus.google.com/+NicholasCronquist",
#       picture: "https://lh3.googleusercontent.com/-EsCQjQiBPtQ/AAAAAAAAAAI/AAAAAAAAe3g/0_Qmno5aAZE/photo.jpg?sz=50",
#       email: "ncron23@gmail.com",
#       email_verified: "true"
#     }
#   }
# }
