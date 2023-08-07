module Api
    module SavedItems
        def api_update_list(object, list, params)
            if params[:add_item]
                list << params[:add_item]
                object.save
            elsif params[:remove_item]
                list.delete params[:remove_item]
                object.save
            end
        end
    end
end