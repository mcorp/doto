Todo::Application.routes.draw do
  # Authentication
  devise_for :users, controllers: { sessions: "sessions" }, skip: [:sessions, :passwords, :confirmations, :registrations]
  as :user do
    # session handling
    get     '/login'  => 'devise/sessions#new',     as: 'new_user_session'
    post    '/login'  => 'devise/sessions#create',  as: 'user_session'
    delete  '/logout' => 'devise/sessions#destroy', as: 'destroy_user_session'

    # joining
    # get   '/join' => 'devise/registrations#new',    as: 'new_user_registration'
    # post  '/join' => 'devise/registrations#create', as: 'user_registration'

    scope '/account' do
      # password reset
      get   '/reset-password'        => 'devise/passwords#new',    as: 'new_user_password'
      put   '/reset-password'        => 'devise/passwords#update', as: 'user_password'
      post  '/reset-password'        => 'devise/passwords#create'
      get   '/reset-password/change' => 'devise/passwords#edit',   as: 'edit_user_password'

      # confirmation
      # get   '/confirm'        => 'devise/confirmations#show',   as: 'user_confirmation'
      # post  '/confirm'        => 'devise/confirmations#create'
      # get   '/confirm/resend' => 'devise/confirmations#new',    as: 'new_user_confirmation'

      # settings & cancellation
      # get '/cancel'   => 'devise/registrations#cancel', as: 'cancel_user_registration'
      # get '/settings' => 'devise/registrations#edit',   as: 'edit_user_registration'
      # put '/settings' => 'devise/registrations#update'

      # account deletion
      delete '' => 'devise/registrations#destroy'
    end
  end

  resources :tasks, only: [:index, :show, :destroy, :create, :update]

  root to: 'home#index'
end
