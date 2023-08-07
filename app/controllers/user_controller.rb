class UserController < ApplicationController
    include ::Api::SavedItems

    def update_magic_items
        api_update_list(Current.user, Current.user.saved_magic_items, params)
        redirect_to magic_items_path, notice: "Updated"
    end

    def update_spells
        api_update_list(Current.user, Current.user.saved_spells, params)
        redirect_to spells_path, notice: "Updated"
    end

    def update_monsters
        api_update_list(Current.user, Current.user.saved_monsters, params)
        redirect_to monsters_path, notice: "Updated"
    end
end
