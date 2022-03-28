Rails.application.routes.draw do

  resources :users
  resources :meetings
  mount EpiCas::Engine, at: "/"
  match "/403", to: "errors#error_403", via: :all
  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all

  get :ie_warning, to: 'errors#ie_warning'

  #Google Calendar API
  get '/redirect', to: 'meetings#redirect', as: 'redirect'
  get '/callback', to: 'meetings#callback', as: 'callback'
  get '/meetings', to: 'meetings#calendars', as: 'calendars'

  get '/events/:calendar_id', to: 'meetings#events', as: 'events', calendar_id: /[^\/]+/
  post '/events/:calendar_id', to: 'meetings#new_event', as: 'new_event', calendar_id: /[^\/]+/

  root to: "pages#home"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
