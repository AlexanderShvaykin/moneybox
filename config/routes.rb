# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :moneyboxes, controller: "moneybox_entries", except: :new
    resources :users, only: [] do
      collection do
        get :me
      end
    end
  end

  resources :tokens, only: :create
end
