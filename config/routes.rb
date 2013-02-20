Vedavaag::Application.routes.draw do

 resources :generals

  resources :transactions do
    get :approve, :on=>:member
    get :text_report, :on=>:member
    get :approve_pay, :on=>:member
  end

  resources :accounts do
    post :csv_import, :on=>:collection
    get :approve, :on=>:member
    get :export, :on=>:collection

  end

  resources :roles

  resources :users do
    get :profile, :on=>:member
    get :update_profile, :on=>:member
    put :profile_update, :on=> :member
    get :change_password, :on=> :member
  end
  resources :user_sessions

  match 'login' => "user_sessions#new", :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout

  root :to => "user_sessions#new"
  match ':controller(/:action(/:id(.:format)))'
end
