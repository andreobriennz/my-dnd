require "test_helper"

class AdventureTest < ActiveSupport::TestCase
    test "adventure created" do
        create_adventure

        assert @adventure.errors.any? == false
        assert @adventure[:title] == 'Some adventure title'
    end

    test "adventure not public by default" do 
        create_adventure

        assert @adventure[:public] != true
    end

    test "adventure updated without errors" do
        create_adventure
        @adventure.attributes = allowed_params
        @adventure.save

        assert @adventure.errors.any? == false
    end

    test "adventure updated correctly" do
        create_adventure
        @adventure.attributes = allowed_params
        @adventure.save

        assert @adventure[:title] == 'Some updated adventure title'
        assert @adventure[:subtitle] == 'Some adventure text'
        assert @adventure[:description] == 'Some adventure text'
        assert @adventure[:public] == true
        assert @adventure[:archived] == true
        assert @adventure[:shared_notes] == 'Some adventure text'
        assert @adventure[:private_notes] == 'Some adventure text'
    end

    test "adventure has correct owner" do
        create_adventure

        assert_not_nil @adventure.campaign[:user_id], "Missing user ID"
        assert @adventure.campaign[:user_id] == @user[:id], "User ID is #{@user[:id]} but adventure user ID is #{@adventure[:user_id]}"
    end

    test "adventure has correct campaign" do
        create_adventure

        assert_not_nil @adventure.campaign
        assert @adventure.campaign[:title] == 'Some campaign title'
    end

    private

    def create_adventure
        @user = users(:one)
        @campaign = @user.campaigns.create({title: 'Some campaign title'})
        @adventure = @campaign.adventures.build({title: 'Some adventure title'})
    end
    
    def allowed_params
        {
            title: 'Some updated adventure title',
            subtitle: 'Some adventure text',
            description: 'Some adventure text',
            public: true,
            archived: true,
            shared_notes: 'Some adventure text',
            private_notes: 'Some adventure text',
        }
    end
end
