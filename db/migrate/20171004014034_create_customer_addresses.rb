class CreateCustomerAddresses < ActiveRecord::Migration
  def change
    create_table :customer_addresses do |t|
      t.references :customer, foreign_key: true
      t.references :address, foreign_key: true
    end
  end
end
