Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end
  
  scope module: :public do
    devise_for :users
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    root to: "homes#top"
    resources :users, only: [:show, :edit, :update]
    resources :post_images do
      get 'search', on: :collection
      resources :post_comments, only: [:create, :destroy]
    end
  end
end
