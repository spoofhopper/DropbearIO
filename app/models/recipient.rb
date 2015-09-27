# == Schema Information
#
# Table name: recipients
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  phone      :string
#  address    :string
#  website    :string
#  image_url  :string
#  group_id   :integer
#  message_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Recipient < ActiveRecord::Base
  belongs_to :group
  belongs_to :message
end
