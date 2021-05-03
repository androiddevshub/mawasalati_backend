Rails.application.routes.draw do
  root to: "landing#index"
  mount Api => "/"
  get "/*path", to: "landing#index", constraints: ->(request) do
                  !request.xhr?
                end

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
