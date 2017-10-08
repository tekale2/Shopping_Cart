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
    def show
      id = params[:id]
      @order = Order.new
      @order = Order.find(id)
      @orders = @order.items.select('items.id','items.price','items.name',:quantity,:totalItemPrice)
    end
    def newItem
      id = params[:id]
      @order = "<input class='form-control' id='order_id'\
           name='order_item[order_id]' value ="+id+" readonly>"
    end
    def addNewItem
        item = Item.find_by(id: params[:order_item][:item_id])
        total = 0
        if(item == nil)
          flash[:notice] = "Add Item failed"
          redirect_to '/customers'
          return
        else
          price = item.price
          total = price*(params[:order_item][:quantity].to_i)
        end
        params[:order_item]["totalItemPrice"]  = total
        @order = OrderItem.find_or_initialize_by(order_id: orderItem_params[:order_id],\
          item_id:orderItem_params[:item_id])
        @order.quantity = orderItem_params[:quantity]
        @order.totalItemPrice = orderItem_params[:totalItemPrice]
        
        if @order.save
            flash[:notice] = "Item was successfully added"
        else
            flash[:notice] = "Add Item failed"
        end
      redirect_to '/customers'
    end
  def destroy
      @order = Order.find(params[:id])
      @order.destroy
      @message = {:message =>"Order successfully deleted"}
      
      render json: @message
    end
  def removeItem
      @orderItem = OrderItem.where(:order_id=>params[:order_id],:item_id=>params[:id])
      @orderItem.first.destroy
      @message = {:message =>"OrderItem successfully deleted from the order"}
      
      render json: @message
  end
  private
  def order_params
    params.require(:order).permit(:placedOn, :customer_id, :payment_id,:address_id)
  end
  def orderItem_params
    params.require(:order_item).permit(:order_id,:item_id,:quantity,:totalItemPrice)
  end
end
