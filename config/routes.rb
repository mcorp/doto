Todo::Application.routes.draw do
  devise_for :users, controllers: { sessions: "sessions" }

  get "(*redirect_path)", to: "batman#index", constraints: lambda { |request| request.format == "text/html" }

  resources :tasks, only: [:index, :show, :destroy, :create, :update]
end
