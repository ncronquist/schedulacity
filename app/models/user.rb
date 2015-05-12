require 'rest-client'

class User < ActiveRecord::Base
  has_many :students
  has_many :classgroups

  has_secure_password

 validates :email,
    presence: true,
    uniqueness: {case_sensitive: false},
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  validates :password,
    presence: true,
    :on => :create

  validates :name,
    presence: true,
    length: {maximum: 35}


  def self.authenticate email, password
    User.find_by_email(email).try(:authenticate, password)
  end

  def refresh_token_if_expired
    if token_expired?

      response = RestClient.post "https://www.googleapis.com/oauth2/v3/token", :grant_type => 'refresh_token', :refresh_token => self.refresh_hash, :client_id => ENV['GOOGLE_CLIENT_ID'], :client_secret => ENV['GOOGLE_CLIENT_SECRET']
      refreshhash = JSON.parse(response.body)

      # token_will_change!
      # expiresat_will_change!

      self.provider_hash     = refreshhash['access_token']
      self.hash_expires_at = DateTime.now + refreshhash["expires_in"].to_i.seconds

      self.save
      puts 'Saved'
    else
      puts "Token not expired. Token not refreshed."
      false
    end
  end

  def token_expired?
    # expiry = Time.at(self.expiresat)
    puts self.hash_expires_at
    expiry = self.hash_expires_at
    return true if expiry < Time.now # expired token, so we should quickly return
    # token_expires_at = expiry
    # save if changed?
    false # token not expired. :D
  end

end
