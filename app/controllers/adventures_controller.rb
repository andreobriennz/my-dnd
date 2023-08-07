class AdventuresController < ApplicationController    
    def show
        @campaign = get_campaign
        @adventure = Adventure.find_by(:slug => params['adventure_slug'])
        print "HEREEE", params['adventure_slug'], "END"
        @is_owner = Current.user ? @campaign.user_id.to_s == Current.user.id.to_s : false
    end
    
    def new
        @campaign = get_campaign
        @adventure = Adventure.new
    end
    
    def create
        campaign = get_campaign
        return nil if campaign == nil # cannot find or no permission

        adventure = Adventure.new allowed_params
        adventure.user_id = Current.user.id
        adventure.campaign_slug = campaign['slug']
        print "??"
        print adventure.save!
        if adventure.save
            redirect_to "/campaigns/#{campaign['slug']}/adventures/#{adventure['slug']}", notice: "New Adventure Created"
        else
            print "WHAT???"
            render :new
        end
    end

    def edit
        campaign = get_campaign
        adventure = Adventure.find_by(:slug => params['adventure_slug'])
        is_owner = Current.user ? campaign.user_id.to_s == Current.user.id.to_s : false
        return nil if is_owner != true

        adventure.attributes = allowed_params
        if adventure.save
            redirect_to "#{campaigns_path}/#{params['campaign_slug']}/adventures/#{params['adventure_slug']}", notice: "Campaign Updated"
        else
          redirect_to "#{campaigns_path}/#{params['campaign_slug']}/adventures/#{params['adventure_slug']}", notice: "Failed to Save"
        end
    end
    
    private

    def get_campaign
        campaign = Campaign.find_by(:slug => params['campaign_slug'])
        current_user_id = Current.user ? Current.user.id.to_s : nil
        if campaign.user_id.to_s == current_user_id || campaign.public
          campaign
        else
          nil
        end
    end
    
    def allowed_params
        params.require(:adventure)
          .permit(
            :title,
            :subtitle,
            :description,
            :public,
            :archived,
            :shared_notes,
            :private_notes,
            :date_started,
            :date_ended,
          )
    end
end
