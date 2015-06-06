Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resources :messages, only: [:new, :create, :show]
    resources :profiles
      match 'profiles', to: 'profiles#new', via: [:get, :post]
      match 'profiles/:id', to: 'profiles#show', via: [:get, :post]
      match 'profiles/:id/edit', to: 'profiles#edit', via: [:get, :post]
  end
  resources :messages do
    get :outbox, action: "outbox", type: "sendmessages", on: :collection #-> domain.com/messages/outbox
    get :inbox, action: "inbox", type: "recivmessages", on: :collection #-> domain.com/messages/inbox
    get :show, action: "show", type: "recivmessages", on: :collection #-> domain.com/messages/allmes
  end
end
