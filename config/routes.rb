Rails.application.routes.draw do
	
  	post 'authenticate', to: 'authentication#authenticate'
	post 'accounts/set_subdomain', to: 'accounts#set_subdomain'
  	namespace :api do
      namespace :v1 do

        resources :conversations
  		resources :users

      end
    end

    resources :accounts
end
