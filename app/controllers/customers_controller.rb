class CustomersController < ApplicationController
    def index
        # nothing
    end
    def show
        print (params)
        @customers = Customer.all
        render json: @customers
    end
end
