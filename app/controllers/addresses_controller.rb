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

    def edit
      id = params[:id]
      @address = Address.find(id)
    end
    def create
        @address = Address.new(addresses_params)
        if @address.save
            flash[:notice] = "Address with id: #{@address.id} was successfully created"
        else
            flash[:notice] = "Create Address Failed"
        end
        redirect_to '/addresses'
    end
    def update
      @address = Address.find params[:id]
      @address.update_attributes!(addresses_params)
      flash[:notice] = " Address details with id #{@address.id} successfully updated."
      redirect_to '/addresses'
    end
    def destroy
        @address = Address.find(params[:id])
        @address.destroy
        @message = {:message =>"Address successfully deleted"}
        
        render json: @message
     end
  private

  def addresses_params
    params.require(:address).permit(:street, :city, :state,:zipcode).
    delete_if {|key, value| value.blank? }
  end
end
