class Attendance < ActiveRecord::Base

  belongs_to :event
  belongs_to :student


  validates :student_id, uniqueness: {scope: :event_id}

end
