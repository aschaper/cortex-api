Rails.application.routes.draw do
  resources :events do
    resources :conditions
    resources :movements

    get 'latest', on: :collection
    post 'send_event_summary', on: :member
  end
end
