Rails.application.routes.draw do
  root 'redirects#to_user_accounts'
  devise_for :users
  
  resources :users, only: [] do
    resources :accounts, only: [:index, :new, :create]
  end

  resources :teams, only: [:index, :new, :create] do
    resources :accounts, only: [:index, :new, :create]

    member do
      get  'invite' => 'team_invites#new'
      post 'invite' => 'team_invites#create', as: 'send_invite'
    end

    collection do
      get  'join' => 'team_invites#join'
      post 'confirm-join' => 'team_invites#confirm_join', as: 'confirm_join'
    end
  end

  resources :topups, only: [:new, :create]
  resources :withdrawals, only: [:new, :create]
end
