Rails.application.routes.draw do
  devise_for :users
  resources :users do
     resources :profiles, :only => [:show, :new, :create, :edit, :update, :destroy]
  end

end
