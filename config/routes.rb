Rails.application.routes.draw do
  devise_for :users
  get 'login/index'
  mount EpiCas::Engine, at: '/'

  get 'pages/guest_page' => 'pages#guest_page', :as => :guest_page

  resources :ecf_notes
  resources :agendas
  resources :decisions

  resources :ecfs do
    member do
      patch 'update_persist', to: 'ecfs#update_persist'
    end

    get :ecfs_gdpr, on: :collection
  end
  get 'ecfs/new' => 'ecfs#new', :as => :new_ecfs

  resources :affected_units
  resources :users do
    collection do
      post 'ldap_user', to: 'users#ldap_user'
      get 'csv_upload', to: 'users#csv_upload'
      post 'import', to: 'users#import'
    end
    member do
      get 'showECFs', to: 'users#showECFs', as: :showECFs
    end
  end
  resources :meetings do
    collection do
      post 'add_pending', to: 'meetings#add_pending'
    end
  end
  resources :emails
  resources :outcomes

  delete 'attachments/:id/purge', to: 'attachments#purge', as: 'purge_attachment'

  match '/403', to: 'errors#error_403', via: :all
  match '/404', to: 'errors#error_404', via: :all
  match '/422', to: 'errors#error_422', via: :all
  match '/500', to: 'errors#error_500', via: :all

  get :ie_warning, to: 'errors#ie_warning'

  # Google Calendar API
  get '/redirect', to: 'meetings#redirect', as: 'redirect'
  get '/callback', to: 'meetings#callback', as: 'callback'
  get '/meetings', to: 'meetings#calendars', as: 'calendars'

  get '/events/:calendar_id', to: 'meetings#events', as: 'events', calendar_id: %r{[^/]+}
  post '/events/:calendar_id', to: 'meetings#new_event', as: 'new_event', calendar_id: %r{[^/]+}

  get :meeting_email, to: 'emails#meeting_email', as: :meeting_email

  # User methods
  # get '/users/csv_upload', to: 'users#csv_upload'

  root to: 'pages#home'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
