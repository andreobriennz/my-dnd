class CampaignsController < ApplicationController
    def index
        return @campaigns = [] if !Current.user
        @campaigns = Current.user.campaigns.order(updated_at: :desc)
    end

    def show
        @campaign = get_campaign(false)
        if @campaign
            @adventures = get_adventures @campaign
            @comments = @campaign.comments.order(:created_at)    
        end
    end

    def new
        @campaign = Campaign.new
    end

    def create
        @campaign = Current.user.campaigns.create allowed_params
        if @campaign.save
            redirect_to "#{campaigns_path}/#{@campaign.slug}", notice: "New Campaign Created"
        else
            render :new
        end
    end

    def update
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

    def is_owner? item
        Current.user ? Current.user.id.to_i == item.user_id.to_i : false
    end

    def has_permission? item, must_be_owner=true
        is_owner = is_owner? item
        is_owner || (item&.public && must_be_owner == false)
    end

    def get_adventures campaign
        adventures = campaign.adventures.order(date_started: :desc)
        adventures.select { |adventure| has_permission? adventure, false }
    end

    def get_campaign(must_be_owner=true)
        campaign = Campaign.find_by(:slug => params['campaign_slug'])
        if campaign && has_permission?(campaign, must_be_owner)
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
