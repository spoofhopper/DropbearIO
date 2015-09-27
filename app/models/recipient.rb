class Recipient < ActiveRecord::Base
  belongs_to :group
  belongs_to :message
end
