module ApplicationHelper
    def markdown(text)
        options = [:hard_wrap, :autolink, :no_intra_emphasis] # , :fenced_code_blocks
        Markdown.new(text, *options).to_html.html_safe
    end

    def is_logged_in?
        !!Current.user
    end

    def to_url *array
        array.join('/')
    end

    def get_slug string
        string.split('/').last
    end

    def to_title string
        string.gsub('_', ' ').gsub('-', ' ').titleize
    end

    def is_owner? item
        # mostly for campaigns and adventures
        Current.user ? item.user_id.to_i == Current.user.id.to_i : false
    end
end