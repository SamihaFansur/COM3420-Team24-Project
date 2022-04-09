Rails.application.routes.draw do

  devise_for :users
  get 'login/index'
  mount EpiCas::Engine, at: "/"

  resources :ecfs
  get 'ecfs/new' => 'ecfs#new', :as => :new_ecfs 

  resources :search do
    collection do
      get 'search', to: 'search#index'
    end
  end

  resources :affected_units
  resources :users do
    collection do
      post 'ldap_user', to: 'users#ldap_user'
      get 'csv_upload', to: 'users#csv_upload'
      post 'import', to: 'users#import'
    end
  end
  resources :meetings
  resources :emails
  
  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_attachment"

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

  get :meeting_email, to: 'emails#meeting_email', as: :meeting_email

  # User methods
  # get '/users/csv_upload', to: 'users#csv_upload'

  root to: "pages#home"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
