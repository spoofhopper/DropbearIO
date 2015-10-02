# == Schema Information
#
# Table name: contacts
#
#  id           :integer          not null, primary key
#  name         :string
#  phone_number :string
#  group_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Contact < ActiveRecord::Base
  belongs_to :group
  validates :name, presence: true,
                    length: { minimum: 5, maximum: 50 }
  validates :phone_number, presence: true,
                    length: { minimum: 10, maximum: 10 }
end
