CapybaraConnectionSharing::Application.routes.draw do
  resources :widgets, only: [:index] do
    collection do
      get :froobicate
    end
  end
end
