# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  image_url   :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Group < ActiveRecord::Base
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :contacts
  validates :name, presence: true,
                    length: { minimum: 5, maximum: 50 }
end




def prepare_group_message_for_sending
  group = {morgan: 14157938267, kisha: 14152343164}
  group.each do |k,v|
    message = "This is a test"
    compose_message(v, message)
  end
end



def send_message_with_twilio(student_mobile, message_body)
  client = Twilio::REST::Client.new(TWILIO_SID, TWILIO_TOKEN)
  client.account.messages.create(from: TWILIO_NUMBER, to: student_mobile, body: message_body)
  puts "Sent Message to #{student_mobile}!"
end



def send_scheduled_messages
  scheduler = Rufus::Scheduler.new
  test = 0
  while test <= 2
    scheduler.every '5s' do
      send_message_to_group
      test += 1
    end
    scheduler.join
  end
end

send_scheduled_messages
