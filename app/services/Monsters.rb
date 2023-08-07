# https://api.open5e.com/v1/monsters/?search=string&cr__gte=number&cr__lte=number

class Monsters
    def initialize(params)
        @params = params
        @query = params
            .permit(:search, :cr__lte, :cr__gte, :page)
            .to_query
    end

    def get_monster
        url = "https://api.open5e.com/v1/monsters/#{@params[:slug]}/"
        response = RestClient.get(url)
        JSON.parse(response)
    end

    def get_monsters
        url = 'https://api.open5e.com/v1/monsters/?'+@query
        print('Get', url)
        response = RestClient.get(url)
        JSON.parse(response)
    end

    def get_my_items all_items
        return [] if !Current.user

        saved_items = Current.user.saved_monsters
        all_items.select { |item| saved_items.include? item['slug'] }
    end
end