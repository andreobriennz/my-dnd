require "test_helper"

class CommentTest < ActiveSupport::TestCase
    test "add comment to campaign" do
        create_adventure
        @commentable = @campaign
        @comment = @commentable.comments.build({
            text: 'My campaign comment',
            commentable_type: 'Campaign',
            commentable_id: 1,
            campaign_id:  @campaign[:id],
        })
        assert @comment.errors.any? == false
        assert @comment[:campaign_id] == @campaign[:id]
    end

    test "add comment to adventure" do
        create_adventure
        @commentable = @adventure
        @comment = @commentable.comments.build({
            text: 'My adventure comment',
            commentable_type: 'Adventure',
            commentable_id: 2,
            adventure_id:  @adventure[:id],
            campaign_id:  @campaign[:id],
        })

        assert @comment.errors.any? == false
        assert @comment[:adventure_id] == @adventure[:id]
    end

    test "pass if has permission" do
        # todo: move to contoller test
        create_adventure
        assert has_permission?(@adventure, @user[:id]) == true
    end

    test "fail if no permission" do
        create_adventure
        assert has_permission?(@adventure, 1234) == false
    end

    private

    def create_adventure
        @user = users(:one)
        @campaign = @user.campaigns.create({title: 'Some campaign title'})
        @adventure = @campaign.adventures.build({title: 'Some adventure title'})
    end

    def has_permission?(item, user_id)
        is_owner =  user_id == item.user_id
        is_owner || item&.public
    end
end
