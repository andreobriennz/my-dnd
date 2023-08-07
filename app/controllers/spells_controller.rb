class SpellsController < ApplicationController
    def index
        magic_items_object = Spells.new params
        @spell_list = magic_items_object.get_spell_list
        @classes = @spell_list.select{ |result| result['name'].titleize }
        @all_spells = @spell_list.reduce([]) { |all, current| all.append(current['spells']) }[0].uniq
        @my_spells = magic_items_object.get_my_spells @all_spells
        if !Current.user
            @my_spells = []
        end
    end

    def show
        magic_items_object = Spells.new params
        @spell = magic_items_object.get_spell
    end
end
