class Event < ActiveRecord::Base

  belongs_to :classgroup
  has_many :attendances
  has_many :students, through: :attendances

end
