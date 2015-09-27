class AddRecipientToMessages < ActiveRecord::Migration
  def change
    add_reference :messages, :recipient, index: true, foreign_key: true
  end
end
