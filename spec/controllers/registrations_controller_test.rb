# spec/controllers/registrations_controller_spec.rb

require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
    describe 'POST #create' do
        before(:each) do
            @valid_user_attributes = {
                email: 'test@example.com',
                username: 'test_user',
                password: 'password',
                password_confirmation: 'password'
            }

            @invalid_user_attributes = {
                password: 'password',
                password_confirmation: 'password'
            }
        end

        context 'when the attributes are valid' do
            it 'creates a new user' do
                expect {
                    post :create, params: { user: @valid_user_attributes }
                }.to change(User, :count).by(1)

                expect(response).to redirect_to(root_path)
                expect(session[:user_id]).to eq(User.last.id)
            end
        end

        context 'when the attributes are invalid' do
            it 'does not create a new user' do
                expect {
                    post :create, params: { user: @invalid_user_attributes }
                }.to change(User, :count).by(0)

                expect(session[:user_id]).to be_nil
            end
        end
    end
end
