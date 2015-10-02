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

require 'twilio-ruby'

class Message < ActiveRecord::Base
  belongs_to :group
  has_many :users, through: :groups
  validates :body, presence: true,
                    length: { minimum: 5, maximum: 160 }


end
