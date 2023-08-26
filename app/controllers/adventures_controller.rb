class AdventuresController < ApplicationController    
    def show
        @campaign = get_campaign(false)
        @adventure = Adventure.find_by(:slug => params['adventure_slug'])
        @comments = @adventure.comments.order(:created_at)
    end
    
    def new
        @campaign = get_campaign
        @adventure = Adventure.new
    end
    
    def create
        @campaign = get_campaign
        return nil if @campaign == nil

        @adventure = @campaign.adventures.build allowed_params
        if @adventure.save
            redirect_to "/campaigns/#{@campaign['slug']}/adventures/#{@adventure['slug']}", notice: "New Adventure Created"
        else
            render :new
        end
    end

    def update
        campaign = get_campaign
        return nil if !campaign

        adventure = Adventure.find_by(:slug => params['adventure_slug'])
        adventure.attributes = allowed_params
        if adventure.save
            redirect_to "#{campaigns_path}/#{params['campaign_slug']}/adventures/#{params['adventure_slug']}", notice: "Campaign Updated"
        else
          redirect_to "#{campaigns_path}/#{params['campaign_slug']}/adventures/#{params['adventure_slug']}", notice: "Failed to Save"
        end
    end
    
    private

    def is_owner? item
        Current.user ? item.user_id.to_i == Current.user.id.to_i : false
    end

    def has_permission? campaign, adventure, must_be_owner=true
        is_owner = is_owner? campaign
        is_owner || (adventure&.public && must_be_owner == false)
    end

    def get_campaign(must_be_owner=true)
        campaign = Campaign.find_by(:slug => params['campaign_slug'])
        adventure = Adventure.find_by(:slug => params['adventure_slug'])
        
        if campaign && has_permission?(campaign, adventure, must_be_owner)
            return campaign
        elsif adventure
            render html: 'Adventure is not public'
            return nil
        else
            render html: '404: Adventure Not Found'
            return nil
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
