Rails.application.routes.draw do

 namespace :admin do
   root to: "homes#top"
   resources :posts, only: [:index, :show, :destroy] do
     resources :comments, only: [:index, :show, :destroy]
     resources :favorites, only: [:index]
   end
   resources :customers, only: [:index, :show, :edit, :update]
 end

devise_scope :public do
  root to: "public/homes#top"
  get 'about' => 'public/homes#about', as: 'about'
  resources :posts, module: 'public' do
    resources :comments, except: [:update]
    resources :favorites, only: [:index, :create, :destroy]
  end
   get 'customers/show' => 'public/customers#show'
   get 'customers/edit' => 'public/customers#edit'
   patch 'customers' => 'public/customers#update'
   get 'customers/unsubscribe' => 'public/customers#unsubscribe', as: 'unsubscribe'
   patch 'customers/withdraw' => 'public/customers#withdraw', as: 'withdraw'
end

devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
