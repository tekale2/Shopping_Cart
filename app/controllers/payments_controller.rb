class PaymentsController < ApplicationController
    def new
         id = params[:id]
         @customer = "<input class='form-control' id='customer_id'\
           name='payment[customer_id]' value ="+id+" readonly>"
    end
    def create
        @payment = Payment.new(payment_params)
        if @payment.save
            flash[:notice] = "Payment with id: #{@payment.id} was successfully created for\
            customer id: #{@payment.customer_id}"
        else
            flash[:notice] = "Create Payment Failed possible duplicate exists"
        end
        redirect_to '/customers'
    end
  private

  def payment_params
    params.require(:payment).permit(:cvv, :cardNo, :cardType,:expiry,:customer_id)
  end
end
