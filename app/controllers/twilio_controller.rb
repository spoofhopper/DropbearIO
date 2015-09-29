require 'twilio-ruby'
#require 'sinatra'


class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token




  def voice
     response = Twilio::TwiML::Response.new do |r|
       r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
       r.Play 'http://linode.rabasa.com/cantina.mp3'
     end

     render_twiml response
  end



  def send_text_message
    twilio_sid = "AC74db4ed4a2b6e400880205014d384761"
    twilio_token = "e6ded52b2286ca47517ae3641be3f54d"
    client = Twilio::REST::Client.new twilio_sid, twilio_token
    from = "+14153608229" #my twilio number

    recipients = {
      "+14157938267" => "Morgan's Verizon"
    }

    recipients.each do |key, value|
      client.account.messages.create(
      :from => from,
      :to => key,
      :body => "Hey #{value}, Party tonight!"
      )
      puts "Sent message to #{value}"
    end

  end


  def sms_reply
    response = Twilio::TwiML::Response.new do |r|
      r.Message "Hey Monkey. Thanks for the message!"
    end
    render_twiml response
  end

end
