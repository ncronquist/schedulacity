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

end
