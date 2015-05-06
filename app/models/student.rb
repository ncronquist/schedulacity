class Student < ActiveRecord::Base

  has_and_belongs_to_many :classgroups
  has_many :contacts
  has_many :attendances
  has_many :events, through: :attendances

end
