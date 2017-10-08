class Payment < ActiveRecord::Base
    belongs_to :customer
    has_many :orders, dependent: :nullify
    validates :cvv, length: { is: 3 }
    validates :cardNo, length: { is: 16 }
    before_save :check_payment

  private

  def check_payment
    if Payment.exists?(cardNo: self.cardNo,\
            cvv: self.cvv, expiry: self.expiry)
        false
    else
        true
    end
  end
end
