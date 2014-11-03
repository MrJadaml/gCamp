Rails.application.routes.draw do

  resources :projects
  resources :users
  resources :tasks do
    collection do
      patch 'complete'
    end
  end

  root "pages#index"
  get  'about'  => 'pages#about', as: :about
  get  'terms'  => 'pages#terms', as: :terms
  get  'faq'    => 'faq#faq',     as: :faq
  get  'signup' => 'registrations#new'
  post 'signup' => 'registrations#create'
  get  'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'
  get 'signout' => 'sessions#destroy'
end
