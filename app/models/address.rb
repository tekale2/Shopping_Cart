class Address < ActiveRecord::Base
    has_many :orders, dependent: :nullify
    has_many :customer_addresses, dependent: :delete_all
    has_many :customers, through: :customer_addresses
end
