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
