# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :moneyboxes, controller: "moneybox_entries", except: %i[new edit] do
      resources :finance_goals, except: %i[new edit], shallow: true
    end
    resources :finance_goals, only: [] do
      resources :planed_expenses, except: %i[new edit], shallow: true
    end
    resources :users, only: [] do
      collection do
        get :me
      end
    end
  end

  resources :tokens, only: :create
end
