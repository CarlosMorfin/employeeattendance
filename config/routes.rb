Rails.application.routes.draw do

  devise_for :users,
    controllers: {
      sessions:  'public/users/sessions'
    }

  namespace :admin do
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
