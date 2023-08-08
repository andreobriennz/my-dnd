class CampaignsController < ApplicationController
    def index
        return @campaigns = [] if !Current.user
        @campaigns = Current.user.campaigns.order(updated_at: :desc)
    end

    def show
        @campaign = get_campaign(false)
        if @campaign != nil
            @owner = User.find_by(:id => @campaign.user_id.to_i)
            @is_owner = Current.user ? @campaign.user_id.to_s == Current.user.id.to_s : false
            @adventures = get_adventures @campaign
        else
            redirect_to '/404'
        end
    end

    def new
        @campaign = Campaign.new
    end

    def create
        user = Current.user
        campaign = user.campaigns.create allowed_params
        if campaign.save
            redirect_to "#{campaigns_path}/#{campaign.slug}", notice: "New Campaign Created"
        else
            render :new
        end
    end

    def edit
        campaign = get_campaign 
        return nil if campaign == nil

        campaign.attributes = allowed_params
        if campaign.save
            redirect_to "#{campaigns_path}/#{campaign.slug}", notice: "Campaign Updated"
        else
            redirect_to "#{campaigns_path}/#{campaign.slug}", notice: "Failed to Save"
        end
    end

    private

    def get_adventures campaign
        campaign.adventures.order(date_started: :desc)
    end

    def get_campaign(must_be_owner=true)
        # returns nil if not found or no permissions (pass true to allow if publiclly visible)
        campaign = Campaign.find_by(:slug => params['campaign_slug'])
        is_owner = Current.user ? Current.user.id == campaign.user_id : false
        is_public = campaign.public

        if is_owner || (is_public && must_be_owner == false)
            return campaign
        else
            return nil
        end
    end

    def allowed_params
        params.require(:campaign)
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
