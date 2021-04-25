# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :user, only: [] do
        collection do
          post :login
          get :logout
          get :ping_role
        end
      end

      resources :event, only: [:index, :create, :show], param: :uid do
        member do
          get :join_event
        end

        resources :token, only: [:create], module: :event do
          collection do
            get :qr_code
          end
        end

        resources :take_part_in_event, only: [:create], module: :event
      end

      resources :tokens, only: [], param: :token_string do
        member do
          get :attendance_by_qr_code
        end
      end

      scope module: :admin do
        resources :event, only: [], param: :event_uid do
          member do
            patch :approve_event
            patch :cancel_event
          end
        end
      end
    end
  end
end
