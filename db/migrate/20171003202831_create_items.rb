class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :price, :null => false
    end
  end
end
