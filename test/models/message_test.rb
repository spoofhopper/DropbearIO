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

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
