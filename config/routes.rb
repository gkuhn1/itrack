Rails.application.routes.draw do

  root 'accounts#index'

  resources :accounts, except: :show do
    member do
      put :update_token, defaults: { :format => :js }
    end

    resources :contacts
  end

end
