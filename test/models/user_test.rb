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
end
