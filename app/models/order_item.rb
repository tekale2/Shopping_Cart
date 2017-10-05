class OrderItem < ActiveRecord::Base
    belongs_to :order
    belongs_to :item
    validates :quantity, presence: true,\
        numericality: { only_integer: true, greater_than: 0 }
    validates :totalItemPrice, presence: true,\
        numericality: { only_integer: true}
end
