module ApplicationHelper
    # todo: move below to buttons helper
    def save_magic_item_button slug
        return "Sign in to save" if !Current.user

        if Current.user.saved_magic_items.include? slug
            return button_to "Remove Item", user_magic_items_path, method: :patch, class: "btn btn-light", params: { remove_item: slug }
        end

        button_to "Save Item", user_magic_items_path, method: :patch, class: "btn btn-dark", params: { add_item: slug }
    end

    def save_spell_button slug
        return "Sign in to save" if !Current.user

        if Current.user.saved_spells.include? slug
            return button_to "Remove Spell", user_spells_path, method: :patch, class: "btn btn-light", params: { remove_item: slug }
        end

        button_to "Save Spell", user_spells_path, method: :patch, class: "btn btn-dark", params: { add_item: slug }
    end

    def save_monster_button slug
        return "Sign in to save" if !Current.user

        if Current.user.saved_monsters.include? slug
            return button_to "Remove Monster", user_monsters_path, method: :patch, class: "btn btn-light", params: { remove_item: slug }
        end

        button_to "Save Monster", user_monsters_path, method: :patch, class: "btn btn-dark", params: { add_item: slug }
    end

    # todo: move below to module
    def hash_to_html_list hash, keys
        keys
            .select { |key| hash[key] != nil && hash[key] != '' }
            .map { |key| "<p>#{key.gsub('_', ' ').titleize }: #{hash[key]}</p>" }.join.html_safe
    end

    def array_to_html_list array
        array.map { |key, value| "<p>#{key.gsub('_', ' ').titleize }: #{value}</p>" }.join.html_safe
    end

    def array_to_html_links array
        array.map { |value| "<p><a href='#{value}'>#{value.split('/').last.titleize}</a></p>" }.join.html_safe
    end

    def calculate_ability_modifier score
        # modifier score = ability score - 10 / 2
        (score - 10) / 2
    end

    def get_ability_modifiers hash
        # sim to hash_to_html_list but adding modifiers
        keys = ['strength', 'dexterity', 'constitution', 'intelligence', 'wisdom', 'charisma']
        keys
            # .select { |key| hash[key] != nil && hash[key] != '' }
            .map do |key|
                """<p>
                    #{key.gsub('_', ' ').titleize }: #{hash[key]} 
                    (#{calculate_ability_modifier hash[key]})
                </p>"""
            end.join.html_safe
    end
end