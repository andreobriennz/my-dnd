class CampaignsController < ApplicationController
    def index
        return @campaigns = [] if !Current.user
        @campaigns = Campaign.where(:user_id => Current.user.id, :archived => false).order(updated_at: :desc)
    end

    def show
        campaign = get_campaign
        if campaign
            @campaign = campaign
            @owner = User.find_by(:id => campaign.user_id.to_i)
            @is_owner = Current.user ? campaign.user_id.to_s == Current.user.id.to_s : false
            @adventures = get_adventures @campaign
        else
            redirect_to '/404'
        end
    end

    def new
        @campaign = Campaign.new
    end

    def create
        # campaign = Campaign.new allowed_params
        # campaign.user_id = Current.user.id

        user = Current.user
        campaign = user.campaigns.create allowed_params

        if campaign
            redirect_to "#{campaigns_path}/#{campaign.slug}", notice: "New Campaign Created"
        else
            render :new
        end
    end

    def edit
        campaign = get_campaign 
        campaign.attributes = allowed_params
        is_owner = Current.user ? campaign.user_id.to_s == Current.user.id.to_s : false
        return nil if is_owner != true

        if campaign.save
            redirect_to "#{campaigns_path}/#{campaign.slug}", notice: "Campaign Updated"
        else
        redirect_to "#{campaigns_path}/#{campaign.slug}", notice: "Failed to Save"
        end
    end

    private

    def get_adventures campaign
        Adventure.where(:campaign_slug => @campaign['slug'], :archived => false)
    end

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
