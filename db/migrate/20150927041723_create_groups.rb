class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
