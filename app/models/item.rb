class Item < ActiveRecord::Base
    has_many :order_items, dependent: :nullify
    has_many :orders, through: :order_items
    validates :price, presence: true,\
        numericality: { only_integer: true}
end