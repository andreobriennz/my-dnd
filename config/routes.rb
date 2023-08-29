Rails.application.routes.draw do
    root "home#index"

    get "sign-up", to: "registrations#new"
    post "sign-up", to: "registrations#create"
    get "sign-in", to: "sessions#new"
    post "sign-in", to: "sessions#create"
    delete "sign-out", to: "sessions#destroy"

    # api based pages - view and save items
    get "/magic-items", to: "magic_items#index"
    get "magic-items/:slug", to: "magic_items#show"
    patch "/user/magic-items", to: "user#update_magic_items"

    get "/monsters", to: "monsters#index"
    get "/monsters/:slug", to: "monsters#show"
    patch "/user/monsters", to: "user#update_monsters"

    get "/spells", to: "spells#index"
    get "/spells/:slug", to: "spells#show"
    patch "/user/spells", to: "user#update_spells"

    # adventures
    get "campaigns/:campaign_slug/adventures/create", to: "adventures#new"
    post "campaigns/:campaign_slug/adventures/create", to: "adventures#create"
    get "campaigns/:campaign_slug/adventures/:adventure_slug", to: "adventures#show"
    put "campaigns/:campaign_slug/adventures/:adventure_slug", to: "adventures#update"

    # campaigns
    get "campaigns", to: "campaigns#index"
    get "campaigns/create", to: "campaigns#new"
    post "campaigns/create", to: "campaigns#create"
    get "campaigns/:campaign_slug", to: "campaigns#show"
    put "campaigns/:campaign_slug", to: "campaigns#update"

    # comments
    resources :campaigns do
        resources :comments, only: [:create]
    end
    resources :adventures do
        resources :comments, only: [:create]
    end
end
