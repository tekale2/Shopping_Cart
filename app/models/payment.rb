class Payment < ActiveRecord::Base
    belongs_to :customer
    has_many :orders, dependent: :nullify
    validates :cvv, length: { is: 3 }
    validates :cardNo, length: { is: 16 }
end
