class TwilioController < ApplicationController

  def index
  end

  def send_text_message

    # render :json => params
    students = Classgroup.find(params['class']).students
    nums=[]
    students.each do |student|
      nums << student.phone_number if student.phone_number != ""
    end


    number_to_send_to = '2069402064'

    twilio_sid = ENV["TWILIO_SID"]
    twilio_token = ENV["TWILIO_TOKEN"]
    twilio_phone_number = "+1 425-629-0770"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    nums.each do |num|
      @twilio_client.account.sms.messages.create(
        :from => "#{twilio_phone_number}",
        :to => num,
        :body => params['twilio']['Hey']
      )
    end

    flash[:info] = "Message sent."
    redirect_to classgroup_path(params['class'])
  end

end