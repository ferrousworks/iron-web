Rails.application.routes.draw do
  devise_for(:accounts)

  authenticate :account, -> (account) {account.administrator?} do
    mount(Flipper::UI.app(Flipper) => "/admin/flipper")
    mount(Sidekiq::Web => "/admin/sidekiq")
  end

  namespace :admin do
    root :to => "pages#admin"
  end

  get "/frontpage" => "pages#show", :as => :frontpage, :format => false, :id => "frontpage"
  get "/pages/*id" => "pages#show", :as => :page, :format => false

  root :to => "pages#show", :id => "landing"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
