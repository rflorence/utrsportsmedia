Rails.application.routes.draw do
  get 'players/index'

  devise_for :users

  root to: "players#index"
end
