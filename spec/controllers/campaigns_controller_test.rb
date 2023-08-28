require 'rails_helper'
require 'factory_bot_rails'

class CampaignsControllerTest < ActionDispatch::IntegrationTest
    require 'rails_helper'

    RSpec.describe CampaignsController, type: :controller do
        before(:each) do
            @user = User.new(username: 'test-campaigns', email: 'test-campaigns@example.com', password: 'password')
            @user.save
            @user = FactoryBot.create(:user)
            allow(Current).to receive(:user).and_return(@user)
            @user.campaigns.create({title: 'Some campaign title 1'})
            @user.campaigns.create({title: 'Some campaign title 2'})
            
            other_user = User.new(username: 'other_user', email: 'test3213@example.com', password: 'password')
            other_user.save
            @public_campaign = other_user.campaigns.create({title: 'Another persons public campaign', public: true})
            @private_campaign = other_user.campaigns.create({title: 'Another persons private campaign'})
        end

        describe 'GET #index' do
            context 'when the user is logged in' do
                it 'gets only their campaigns' do
                    get :index
                    expect(assigns(:campaigns).count).to equal(2)
                end
            end
        end

        describe 'GET #show' do
            context 'when the user is logged in' do
                it 'gets one of their campaigns' do
                    get :show, params: { :campaign_slug => @user.campaigns.first[:slug] }
                    expect(assigns(:campaign)).not_to be_nil
                end
            end

            context 'when the user is not the owner' do
                it 'the campaign if is public' do
                    get :show, params: { :campaign_slug => @public_campaign[:slug] }
                    expect(assigns(:campaign)).not_to be_nil
                end

                it 'fails to get the campaign if is not public' do
                    get :show, params: { :campaign_slug => @private_campaign[:slug] }
                    expect(assigns(:campaign)).to be_nil
                end
            end
        end

        describe 'POST #create' do
            context 'when creating a campaign' do
                it 'creates the campign if it has a title' do
                    campaign_params = { title: 'Test create campaign' }
                    post :create, params: { campaign: campaign_params }
                    expect(assigns(:campaign)).to be_truthy
                end
            end
        end

        describe 'PUT #update' do
            campaign_params = { title: 'Test update campaign', subtitle: 'Add subtitle' }
            context 'when updating a campaign' do
                it 'updates the campign if the user is the owner' do
                    put :update, params: { :campaign_slug => @user.campaigns.first[:slug], campaign: campaign_params }
                    expect(assigns(:campaign)[:subtitle]).to eq('Add subtitle')
                end

                it 'fails to update the campign if the user is not the owner' do
                    # campaign is public but owned by a different user
                    put :update,  params: { :campaign_slug => @public_campaign, campaign: campaign_params }
                    expect(assigns(:campaign)).to be_falsey
                end
            end
        end
    end    
end
