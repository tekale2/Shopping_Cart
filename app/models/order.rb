class Order < ActiveRecord::Base
    belongs_to :customer
    belongs_to :payment
    belongs_to :address
    has_many :order_items, dependent: :delete_all
    has_many :items, through: :order_items
end
