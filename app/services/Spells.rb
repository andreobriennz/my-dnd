class Spells
    def initialize params
        @params = params
    end

    def get_spell
        url = "https://api.open5e.com/v1/spells/#{@params[:slug]}/"
        response = RestClient.get(url)
        JSON.parse(response)
    end

    def get_spell_list
        class_name = @params[:class_name]
        url = 'https://api.open5e.com/v1/spelllist/'
        response = RestClient.get(url)
        JSON.parse(response)['results']
    end

    def get_my_spells all_spells
        if Current.user
            saved_spells = Current.user.saved_spells
            all_spells.select { |spell| saved_spells.include? spell }
        end
    end
end