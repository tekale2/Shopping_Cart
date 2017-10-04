class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :placedOn, :null => false
      t.references :customer, foreign_key: true
      t.references :address, foreign_key: true
      t.references :payment, foreign_key: true
    end
  end
end
