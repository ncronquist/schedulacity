class ClassgroupsStudents < ActiveRecord::Base
  belongs_to :classgroup
  belongs_to :student
end
