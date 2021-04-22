Rails.application.routes.draw do

  root 'events#index'

  resources :events do
    resources :registrations
  end

  # get "events/:event_id/registrations", to: "registrations#index"

end
