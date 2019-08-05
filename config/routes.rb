Rails.application.routes.draw do
  root 'teams#index'
  devise_for :users
  
  resources :teams, only: [:index, :new, :create] do
    member do
      get  'invite', to: 'team_invites#new'
      post 'invite', to: 'team_invites#create', as: 'send_invite'
    end

    collection do
      get  'join', to: 'team_invites#join'
      post 'confirm-join', to: 'team_invites#confirm_join', as: 'confirm_join'
    end
  end

end
