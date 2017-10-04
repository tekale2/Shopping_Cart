class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :cvv, :null => false
      t.string :cardNo, :null => false
      t.string :cardType, :null => false
      t.date :expiry, :null => false
      t.references :customer, foreign_key: true
    end
  end
end
