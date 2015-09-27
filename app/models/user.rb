# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  phone      :string
#  address    :string
#  website    :string
#  image_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_many :groups
  has_many :messages, through: :groups

  has_many :owners, class_name: "Owner",
                    foreign_key: "owner_id"

  has_many :recipients, class_name: "Recipient",
                        foreign_key: "recipient_id"





end
