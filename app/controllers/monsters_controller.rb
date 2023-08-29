class MonstersController < ApplicationController
    def index
        monsters_object = Monsters.new params
        response = monsters_object.get_monsters
        @all_monsters = response['results']
        @previous, @next = response['previous'], response['next']
        @saved_monsters = monsters_object.get_my_items
    end

    def show
        monsters_object = Monsters.new params
        @monster = monsters_object.get_monster
    end
end
