Rails.application.routes.draw do
  resources :events do
    resources :conditions

    get 'latest', on: :collection
    post 'send_event_summary', on: :member
  end
end
