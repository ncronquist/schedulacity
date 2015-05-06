class User < ActiveRecord::Base

  has_many :classgroups

  has_secure_password

end
