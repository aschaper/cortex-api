Rails.application.routes.draw do
  resources :events do
    resources :conditions
    resources :movements

    get 'latest', on: :collection
    post 'stop', on: :member
  end
end
