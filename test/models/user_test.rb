require "test_helper"

class UserTest < ActiveSupport::TestCase
    test "user created" do
        user = User.new(username: "testuser", email: "test@example.com", password: "password")
        assert user.save
    end

    test "username required" do
        user = User.new(email: "test@example.com", password: "password")
        assert_not user.save, "Saved the user without a username"
    end

    test "email required" do
        user = User.new(username: "testuser", password: "password")
        assert_not user.save, "Saved the user without an email"
    end

    test "password required" do
        user = User.new(username: "testuser", email: "test@example.com")
        assert_not user.save, "Saved the user without a password"
    end

    test "should not create user with duplicate email" do
        existing_user = users(:one) # Use an existing fixture user
        new_user = User.new(
        email: existing_user.email,
        username: "new_username",
        password: "password"
        )
        assert_not new_user.save, "Created a user with duplicate email"
    end

    test "should not create user with duplicate username" do
        existing_user = users(:one) # Use an existing fixture user
        new_user = User.new(
        email: "new_email@example.com",
        username: existing_user.username,
        password: "password"
        )
        assert_not new_user.save, "Created a user with duplicate username"
    end

    test "user can log in with correct password" do
        user = User.create(username: "testuser", email: "test@example.com", password: "password")
        assert user.authenticate("password"), "User couldn't log in with correct password"
    end

    test "log in fails with wrong password" do
        user = User.create(username: "testuser", email: "test@example.com", password: "password")
        assert_not user.authenticate("wrong_password"), "User logged in with wrong password"
    end

    test "deleting user also deletes campaigns" do
        user = User.new(username: "testuser2", email: "test2@example.com", password: "password")
        user.save
        campaign = user.campaigns.create({title: 'Some campaign title'})

        assert Campaign.where(:user_id => user[:id]).count >= 0, "No campaigns to test"
        user.destroy
        assert Campaign.where(:user_id => user[:id]).count == 0, "Failed to delete campaigns"
    end

    test "deleting user also deletes adventures" do
        user = User.new(username: "testuser2", email: "test2@example.com", password: "password")
        user.save
        campaign = user.campaigns.create({title: 'Some campaign title'})
        adventure = campaign.adventures.build({title: 'Some adventure title'})
        
        assert Adventure.where(:campaign_id => campaign[:id]).count >= 0, "No adventures to test"
        user.destroy
        assert Adventure.where(:campaign_id => campaign[:id]).count == 0, "Failed to delete adventures"
    end
end
