Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resources :messages, only: [:new, :create, :show]
  end
  resources :messages do
    get :outbox, action: "outbox", type: "sendmessages", on: :collection #-> domain.com/messages/outbox
    get :inbox, action: "inbox", type: "recivmessages", on: :collection #-> domain.com/messages/inbox
    get :show, action: "show", type: "recivmessages", on: :collection #-> domain.com/messages/allmes
  end
  resources :profiles
end
