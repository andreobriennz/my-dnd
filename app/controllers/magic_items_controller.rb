class MagicItemsController < ApplicationController
    def index
        magic_items_object = MagicItems.new params
        @all_items = magic_items_object.get_magic_items
        @my_items = magic_items_object.get_my_items @all_items
    end 

    def index_json
        magic_items_object = MagicItems.new params
        @items = magic_items_object.get_magic_items
        render json: @items
    end
end
