class CampaignsController < ApplicationController
    def index
        return @campaigns = [] if !Current.user
        @campaigns = Current.user.campaigns.order(updated_at: :desc)
    end

    def show
        @campaign = get_campaign(false)
        if @campaign
            @owner = User.find_by(:id => @campaign.user_id.to_i)
            @is_owner = is_owner? @campaign
            @adventures = get_adventures @campaign
            @comments = @campaign.comments.order(:created_at)    
        end
    end

    def new
        @campaign = Campaign.new
    end

    def create
        campaign = Current.user.campaigns.create allowed_params
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

    def is_owner? campaign_or_adventure
        Current.user ? Current.user.id.to_i == campaign_or_adventure.user_id.to_i : false
    end

    def get_adventures campaign
        adventures = campaign.adventures.order(date_started: :desc)
        adventures.select do |adventure|
            is_owner = is_owner? adventure
            adventure&.public || is_owner
            # true
        end
    end

    def get_campaign(must_be_owner=true)
        # returns nil if not found or no permissions (pass true to allow if publiclly visible)
        campaign = Campaign.find_by(:slug => params['campaign_slug'])
        is_owner = is_owner? campaign
        is_public = campaign&.public
        if is_owner || (is_public && must_be_owner == false)
            return campaign
        elsif campaign
            render html: 'Campaign is not public'
            return nil
        else
            render html: '404: Campaign Not Found'
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
