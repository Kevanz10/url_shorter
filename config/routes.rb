Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'short_urls#index'
  require 'sidekiq/web'
  resources :short_urls
  mount Sidekiq::Web => '/sidekiq'

  get '/:short_url_id', to: 'short_urls#redirection', as: 'redirection'
  get '/url/error', to: 'error_urls#url_not_found', as: 'url_not_found'
end
