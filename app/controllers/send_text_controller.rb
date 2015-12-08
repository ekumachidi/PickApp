class SendTextController < ApplicationController
  def index
  end

  def send_text_message
    number_to_send_to = params[:number_to_send_to]

    twilio_sid = "AC66ec886855bc1c40ebdf5f08d521f970"
    twilio_token = "33ef2e56daef57bf296372fc3caa1a83"
    twilio_phone_number = "2403396295"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => "+1#{2403396295}",
      :to => number_to_send_to,
      :body => "This is an message. It gets sent to #{number_to_send_to}"
    )
  end
end
