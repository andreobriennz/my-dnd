require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    describe 'POST #create' do
        before(:each) do
            @user = User.new(username: 'test_user', email: 'test@example.com', password: 'password')
            @user.save
        end
    
        context 'when the credentials are valid' do
            it 'logs the user in' do
                post :create, params: { username: @user.username, password: @user.password }
                expect(@user.id).not_to be_nil
                expect(session[:user_id]).not_to be_nil
                expect(session[:user_id]).to eq(@user.id)
            end

            # it 'redirects to the home page' do
            #     post :create, params: { username: user.username, password: user.password }
            #     expect(response).to redirect_to(root_path)
            # end
        end

        context 'when the credentials are invalid' do
            it 'does not log the user in' do
                post :create, params: { username: @user.username, password: 'wrong_password' }
                expect(session[:user_id]).to be_nil
            end

            # it 'renders the new template' do
            #     post :create, params: { username: user.username, password: 'wrong_password' }
            #     expect(response).to render_template('new')
            # end
        end
    end

    describe 'DELETE #destroy' do
        before(:each) do
            @user = User.new(username: 'test_user', email: 'test@example.com', password: 'password')
            @user.save
        end

        it 'logs the user out' do
            post :create, params: { username: @user.username, password: @user.password }
            expect(session[:user_id]).not_to be_nil
            delete :destroy
            expect(session[:user_id]).to be_nil
        end

        # it 'redirects to the home page' do
        #     session[:user_id] = user.id
        #     delete :destroy
        #     expect(response).to redirect_to(root_path)
        # end
    end
end
