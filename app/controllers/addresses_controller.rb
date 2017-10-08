class AddressesController < ApplicationController
    def index
        # nothing
    end
    def display
        list = addresses_params
        if list.empty?
            @addresses = Address.all
        else
            @addresses = Address.where(list)
        end
        render json: @addresses
    end
  
  private

  def addresses_params
    params.require(:address).permit(:street, :city, :state,:zipcode).
    delete_if {|key, value| value.blank? }
  end
end
