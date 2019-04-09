Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  resources :questions do
    resources :answers, shallow: true, only: %i[create update destroy] do
      patch 'select_best', on: :member
    end
  end
end
