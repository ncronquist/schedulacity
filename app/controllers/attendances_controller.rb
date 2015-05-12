class AttendancesController < ApplicationController

  before_action :is_authenticated?

  def create
    # render :json => params

    params[:student].each do |student_id, attendance_type|
      # student = Student.find(student_id)
      attendance = Attendance.where(:student_id => student_id, :event_id => params[:event_id]).first_or_initialize
      attendance.attendance_type = attendance_type.to_i
      attendance.student_id = student_id
      attendance.event_id = params[:event_id]
      attendance.save
      flash[:success] = "Attendance successfully updated."

      # student.attendances << attendance
    end


    # @attendances = Attendance.new
    # @attendances = Attendance.where(event_id: @event.id)
    # # @attendnces = Attendance.attendance_type
    # @attendane = Attendance.save
    # render :json => @attendances
    redirect_to :back
  end







end

