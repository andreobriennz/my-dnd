module CampaignsHelper
    def campaign_path campaign_slug
        "#{campaigns_path}/#{campaign_slug}"
    end
end
