class CustomersController < ApplicationController
    def index
        # nothing
    end
    def show
        list = customer_params
        if list.empty?
            @customers = Customer.all
        else
            @customers = Customer.where(list)
        end
        render json: @customers
    end
  
  private

  def customer_params
    params.require(:customer).permit(:name, :email, :contact).
    delete_if {|key, value| value.blank? }
  end
end
