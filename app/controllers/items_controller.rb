class ItemsController < ApplicationController
    def index
        # nothing
    end
    def show
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
  
  private

  def items_params
    params.require(:item).permit(:name, :from, :to).
    delete_if {|key, value| value.blank? }
  end
end
