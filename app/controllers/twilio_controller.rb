require 'twilio-ruby'

class TwilioController < ApplicationController

  def home
  end

  include Webhookable

  #after_filter :set_header #Set up the response header in the set_header method which gets called in after_filter method.

  skip_before_action :verify_authenticity_token

  def voice
     response = Twilio::TwiML::Response.new do |r|
       r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
       r.Play 'http://linode.rabasa.com/cantina.mp3'
     end

     render_twiml response
  end





  def sms_reply
    response = Twilio::TwiML::Response.new do |r|
      r.Message "Hey Monkey. Thanks for the message!"
    end
    render_twiml response
  end


end
