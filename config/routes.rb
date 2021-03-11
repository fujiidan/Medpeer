Rails.application.routes.draw do
  resources :ideas, only: :create do
    get 'search', on: :collection
  end  
end
