class ItemsController < ApplicationController
    def index
        # nothing
    end
    def edit
      id = params[:id]
      @item = Item.find(id)
    end
    def update
      @item = Item.find params[:id]
      @item.update_attributes!(items_params)
      flash[:notice] = " Item details with id #{@item.id} successfully updated."
      redirect_to '/items'
    end
    def display
        list = items_params
        min = 0
        max = 200
        if list.key?("from")
            min =list["from"].to_i.abs
        end
        if list.key?("to")
            max = list["to"].to_i.abs
        end
        if min > max
            min,max = max,min
        end
        if list.empty?
            @items = Item.all
        elsif list.key?("name")
            @items = Item.where(["name = ? and price >= ? and price <= ?",list["name"],\
            min,max])
        else
            @items = Item.where(["price >= ? and price <= ?",min,max])
        end
        render json: @items
    end
    def create
        @item = Item.new(items_params)
        if @item.save
            flash[:notice] = "Item with id: #{@item.id} was successfully created"
        else
            flash[:notice] = "Create Item Failed"
        end
        redirect_to '/items'
    end
    def destroy
        @item = Item.find(params[:id])
        @item.destroy
        @message = {:message =>"Item successfully deleted"}
        
        render json: @message
      end
  private

  def items_params
    params.require(:item).permit(:name, :from, :to,:price,:description).
    delete_if {|key, value| value.blank? }
  end
end
