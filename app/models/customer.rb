class Customer < ActiveRecord::Base
    has_many :payments, dependent: :delete_all
    has_many :orders, dependent: :delete_all
    has_many :customer_addresses, dependent: :delete_all
    has_many :addresses, through: :customer_addresses
    validates :name, presence: true
    validates :email, presence: true
    validates :contact, presence: true, length: { is: 12}
end
