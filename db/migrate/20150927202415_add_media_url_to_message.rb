class AddMediaUrlToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :MediaURL, :string
  end
end
