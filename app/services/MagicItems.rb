class MagicItems
    def initialize(params)
        @params = params
        @query = params
            .permit(:search, :rarity, :page)
            .to_query
    end

    def get_magic_items
        url = 'https://api.open5e.com/v1/magicitems/?'+@query
        response = RestClient.get(url)
        JSON.parse(response)
    end

    def get_magic_item slug
        url = "https://api.open5e.com/v1/magicitems/?slug__in=#{slug}"
        response = RestClient.get(url)
        all_items = JSON.parse(response)['results'].first
    end

    def get_my_items
        return [] if !Current.user

        saved_items = Current.user.saved_magic_items
        return [] if Current.user.saved_magic_items.length == 0

        url = "https://api.open5e.com/v1/magicitems/?slug__in=#{saved_items.join(',')}"
        response = RestClient.get(url)
        all_items = JSON.parse(response)['results']
    end
end