class TwilioController < ApplicationController

  def index
  end

  def send_text_message

    # render :json => params

    number_to_send_to = '2069402064'

    twilio_sid = ENV["TWILIO_SID"]
    twilio_token = ENV["TWILIO_TOKEN"]
    twilio_phone_number = "+1 425-629-0770"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => "#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => params['twilio']['Hey']
    )

    redirect_to root_path
  end

end