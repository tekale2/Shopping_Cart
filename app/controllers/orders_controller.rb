class OrdersController < ApplicationController
    def new
         id = params[:id]
         cust = Customer.find(id)
         @paylist = cust.payments.pluck(:id)
         @addressList = cust.addresses.pluck(:id)
         @customer = "<input class='form-control' id='customer_id'\
           name='order[customer_id]' value ="+id+" readonly>"
           
    end
    def create
        @order = Order.create!(order_params)
        flash[:notice] = "Order with id: #{@order.id} was successfully created for\
        customer id: #{@order.customer_id}"
        redirect_to '/customers'
    end
  private

  def order_params
    params.require(:order).permit(:placedOn, :customer_id, :payment_id,:address_id)
  end
end
