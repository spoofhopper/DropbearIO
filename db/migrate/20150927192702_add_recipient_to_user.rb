class AddRecipientToUser < ActiveRecord::Migration
  def
    create_table :recipients do |t|
      t.timestamps null: false
    end
  end
end
