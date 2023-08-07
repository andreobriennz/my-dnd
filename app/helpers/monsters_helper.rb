module MonstersHelper
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

    def get_ability_modifiers hash
        # sim to hash_to_html_list but adding modifiers
        keys = ['strength', 'dexterity', 'constitution', 'intelligence', 'wisdom', 'charisma']
        keys
            .map do |key|
                """<p>
                    #{key.gsub('_', ' ').titleize }: #{hash[key]} 
                    (#{calculate_ability_modifier hash[key]})
                </p>"""
            end.join.html_safe
    end

    private

    def calculate_ability_modifier score
        # modifier score = ability score - 10 / 2
        (score - 10) / 2
    end
end
