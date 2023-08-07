class MagicItems
    def initialize(params)
        @params = params
    end

    def get_magic_items
        url = 'https://api.open5e.com/v1/magicitems/'
        search = @params[:search]
        rarity = @params[:rarity]
        if search
            url = url+'?search='+search      
        end
        
        response = RestClient.get(url)
        all_items = JSON.parse(response)['results']
    
        if rarity && rarity != ''
            all_items = all_items.select { |item| item['rarity'].downcase == rarity }
        end

        all_items
    end

    def get_my_items all_items
        return [] if !Current.user

        saved_items = Current.user.saved_magic_items
        all_items.select { |item| saved_items.include? item['slug'] } 
    end
end