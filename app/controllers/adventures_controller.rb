class AdventuresController < ApplicationController    
    def show
        @campaign = get_campaign(false)
        @adventure = Adventure.find_by(:slug => params['adventure_slug'])
        @is_owner = is_owner? @adventure
        @comments = @adventure.comments.order(:created_at)
    end
    
    def new
        @campaign = get_campaign
        @adventure = Adventure.new
    end
    
    def create
        @campaign = get_campaign
        return nil if @campaign == nil

        adventure_params = { **allowed_params, user_id: Current.user.id }
        @adventure = @campaign.adventures.create adventure_params
        if @adventure.save
            redirect_to "/campaigns/#{@campaign['slug']}/adventures/#{@adventure['slug']}", notice: "New Adventure Created"
        else
            render json: @adventure.errors
        end
    end

    def edit
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

    def is_owner? campaign_or_adventure
        Current.user ? campaign_or_adventure.user_id.to_i == Current.user.id.to_i : false
        # render html: "#{campaign_or_adventure.user_id} + #{Current.user.id}"
    end

    def get_campaign(must_be_owner=true)
        # returns nil if not found or no permissions (pass true to allow if publiclly visible)
        campaign = Campaign.find_by(:slug => params['campaign_slug'])
        adventure = Adventure.find_by(:slug => params['adventure_slug'])
        is_owner = is_owner? campaign

        if is_owner || (adventure.public && must_be_owner == false)
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
