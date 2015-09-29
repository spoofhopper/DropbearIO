require 'twilio-ruby'

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
