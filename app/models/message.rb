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



class Message < ActiveRecord::Base
  belongs_to :group
  has_many :users, through: :groups
  validates :body, presence: true,
                    length: { minimum: 5, maximum: 160 }
  validates :group_id, presence: true
  validates :date, presence: true
  after_create :schedule_message



 def self.send_message_with_twilio ( phone_number, name, body )

   sid = "AC74db4ed4a2b6e400880205014d384761"
   token = "e6ded52b2286ca47517ae3641be3f54d"

    client = Twilio::REST::Client.new(sid, token)

    client.account.messages.create(
    from: "+14153608229",
    to: phone_number,
    body: body
    #media_url: "image url"
    )

    puts "Sent Message to #{name}!"

  end

  def schedule_message
    scheduler = Rufus::Scheduler.new
    scheduler.at date do
      group.contacts.each do | contact |
        Message.send_message_with_twilio(contact.phone_number, contact.name, body)
      end
    end
    scheduler.join
  end


end
