# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  header       :string
#  body         :text
#  link         :string
#  image_url    :string
#  date         :datetime
#  sent         :boolean
#  scheduled    :boolean
#  group_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  MediaURL     :string
#

require 'pp'

class Message < ActiveRecord::Base
  belongs_to :group
  has_many :users, through: :groups
  validates :body, presence: true,
                    length: { minimum: 5, maximum: 160 }
  validates :group_id, presence: true
  validates :date, presence: true
  after_create :schedule_message



 def self.send_message_with_twilio ( phone_number, name, body )

    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token

    client.account.messages.create(
      from: Rails.application.secrets.twilio_phone_number,
      to: phone_number,
      body: body
      #media_url: "image url"
    )

    puts "Sent Message to #{name}!"

  end

  def schedule_message
      group.contacts.each do | contact |
        Message.delay(run_at: date).send_message_with_twilio(contact.phone_number, contact.name, body)
      end
  end

end
