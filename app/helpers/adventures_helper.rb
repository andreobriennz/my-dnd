module AdventuresHelper
    def adventure_path campaign_slug, adventure_slug
        "#{campaigns_path}/#{campaign_slug}/adventures/#{adventure_slug}"
    end
end
