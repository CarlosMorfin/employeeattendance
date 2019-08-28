Rails.application.routes.draw do

  devise_for :users,
    controllers: {
      sessions:  'public/users/sessions'
    }

  devise_scope :user do
    root 'public/users/sessions#new'
  end

  namespace :admin do
    root to: 'root#show'
    resources :employees do
      resource :user,
        controller: 'employees/users',
        only: [:show]
    end
    resources :attendances,
      only: [:index, :create, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
