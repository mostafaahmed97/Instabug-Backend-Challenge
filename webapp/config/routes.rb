Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  # This hooks the CRUD methods of Application controller to routes
  # param: token changes parameter of URL to /:token instead of /:id
  resources :applications, param: :token do
    resources :chats, param: :number
  end
end
