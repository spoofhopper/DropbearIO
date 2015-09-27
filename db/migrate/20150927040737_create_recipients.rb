class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :website
      t.string :image_url
      t.references :group, index: true, foreign_key: true
      t.references :message, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
