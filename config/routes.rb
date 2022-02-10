Rails.application.routes.draw do

  mount EpiCas::Engine, at: "/"
  match "/403", to: "errors#error_403", via: :all
  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all

  get :ie_warning, to: 'errors#ie_warning'

  root to: "pages#home"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
