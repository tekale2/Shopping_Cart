class AddTotalItemPriceToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :totalItemPrice, :integer
  end
end
