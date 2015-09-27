class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :website
      t.string :image_url

      t.timestamps null: false
    end
  end
end
