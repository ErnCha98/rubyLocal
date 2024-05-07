Rails.application.routes.draw do

  #post '/proxy/3000', to: 'todo_filter_controller#filter_action'

  #scope '(proxy/3000)' do 
  resources :todos
  post '/todos/filter', to: 'todos#filter'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "todos#index"
 # end
end
