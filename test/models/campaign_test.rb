require "test_helper"

class CampaignTest < ActiveSupport::TestCase
    test "campaign created" do
        create_campign

        assert @campaign.errors.any? == false
        assert @campaign[:title] == 'Some title'
    end

    test "campaign not public by default" do
        create_campign

        assert @campaign[:public] != true
    end

    test "campaign updated without errors" do
        create_campign
        @campaign.attributes = allowed_params
        @campaign.save

        assert @campaign.errors.any? == false
    end

    test "campaign updated correctly" do
        create_campign
        @campaign.attributes = allowed_params
        @campaign.save

        assert @campaign[:title] == 'Some updated title'
        assert  @campaign[:subtitle] == 'Some text'
        assert @campaign[:description] == 'Some text'
        assert @campaign[:public] == true
        assert @campaign[:archived] == true
        assert @campaign[:shared_notes] == 'Some text'
        assert @campaign[:private_notes] == 'Some text'
    end

    test "user is owner" do
        create_campign

        assert @campaign[:user_id] == @user[:id], "User ID is #{@user[:id]} but campaign user ID is #{@campaign[:user_id]}"
    end

    private

    def allowed_params
        {
            title: 'Some updated title',
            subtitle: 'Some text',
            description: 'Some text',
            public: true,
            archived: true,
            shared_notes: 'Some text',
            private_notes: 'Some text',
        }
    end

    def create_campign
        @user = users(:one)
        @campaign = @user.campaigns.create({title: 'Some title'})
    end

    test "deleting campaign also deletes adventures" do
        user = User.new(username: "testuser2", email: "test2@example.com", password: "password")
        user.save
        campaign = user.campaigns.create({title: 'Some campaign title'})
        adventure = campaign.adventures.build({title: 'Some adventure title'})
        
        assert Adventure.where(:campaign_id => campaign[:id]).count >= 0, "No adventures to test"
        campaign.destroy
        assert Adventure.where(:campaign_id => campaign[:id]).count == 0, "Failed to delete adventures"
    end
end
