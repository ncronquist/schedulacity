class TwilioController < ApplicationController

  def index
  end

  def send_text_message

    students = Classgroup.find(params['class']).students
    nums=[]
    students.each do |student|
      nums << student.phone_number if student.phone_number != ""
    end

    twilio_sid = ENV["TWILIO_SID"]
    twilio_token = ENV["TWILIO_TOKEN"]
    twilio_phone_number = "+14252767254"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    nums.each do |num|
      @twilio_client.account.messages.create({
        :from => "#{twilio_phone_number}",
        :to => num,
        :body => "#{params['twilio']['Hey']} - Sent using Schedualicty"
      })
    end

    flash[:info] = "Message sent."
    redirect_to classgroup_path(params['class'])
  end

  def single_message
    student = Student.find(params['id'])
    num = student.phone_number
    twilio_sid = ENV["TWILIO_SID"]
    twilio_token = ENV["TWILIO_TOKEN"]
    twilio_phone_number = "+14252767254"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    @twilio_client.account.messages.create({
      :from => "#{twilio_phone_number}",
      :to => num,
      :body => "#{params['twilio']['Hey']} - Sent using Schedulacity"
    })

    flash[:info] = 'Message sent.'
    redirect_to student_path(params['id'])
  end

end