class CommentsController < ApplicationController
    def create
        @commentable = find_commentable
        @comment = @commentable.comments.build(comment_params)
        @comment.user = Current.user

        if has_permission?(@commentable) && @comment.save
            flash[:notice] = 'Comment added'
            redirect_back(fallback_location: '/')
        else
            flash[:alert] = 'Error adding comment'
            redirect_to '/' # todo
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:text, :commentable_type, :commentable_id, :adventure_id, :campaign_id, :is_csv)
    end

    def find_commentable
        if params[:campaign_id]
            Campaign.find(params[:campaign_id])
        elsif params[:adventure_id]
            Adventure.find(params[:adventure_id])
        else
            nil
        end
    end

    def commentable_path commentable
        case commentable
        when Adventure
          adventure_path commentable
        when Campaign
          campaign_path commentable
        else
          root_path
        end
    end

    def has_permission? item
        is_owner =  Current.user ? Current.user.id.to_i == item.user_id.to_i : false
        is_owner || item&.public
    end
end
