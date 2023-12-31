module ApiHelper
    def save_magic_item_button slug
        return link_to "Log In", sign_in_path, class: "button button- button-small" if !Current.user

        if Current.user.saved_magic_items.include? slug
            return button_to "Remove Item", user_magic_items_path, method: :patch, class: "button button-dark button-small", params: { remove_item: slug }
        end

        button_to "Save Item", user_magic_items_path, method: :patch, class: "button button- button-small", params: { add_item: slug }
    end

    def save_spell_button slug
        return link_to "Log In", sign_in_path, class: "button button- button-small" if !Current.user

        if Current.user.saved_spells.include? slug
            return button_to "Remove Spell", user_spells_path, method: :patch, class: "button button-dark button-small", params: { remove_item: slug }
        end

        button_to "Save Spell", user_spells_path, method: :patch, class: "button button- button-small", params: { add_item: slug }
    end

    def save_monster_button slug
        return link_to "Log In", sign_in_path, class: "button button- button-small" if !Current.user

        if Current.user.saved_monsters.include? slug
            return button_to "Remove Monster", user_monsters_path, method: :patch, class: "button button-dark button-small", params: { remove_item: slug }
        end

        button_to "Save Monster", user_monsters_path, method: :patch, class: "button button- button-small", params: { add_item: slug }
    end
end
