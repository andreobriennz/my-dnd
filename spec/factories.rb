require 'factory_bot_rails'

FactoryBot.define do
    factory :user do
      username { 'test_user' }
      email { 'test@example.com' }
      password { 'password' }
    end
end