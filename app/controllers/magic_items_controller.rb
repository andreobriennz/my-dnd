class MagicItemsController < ApplicationController
    def index
        magic_items_object = MagicItems.new params

        response = magic_items_object.get_magic_items
        @all_items = response['results']
        @previous, @next = response['previous'], response['next']

        @my_items = magic_items_object.get_my_items
    end 

    def show
        magic_items_object = MagicItems.new params
        @item = magic_items_object.get_magic_item params['slug']
    end
end
