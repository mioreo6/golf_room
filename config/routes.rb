Rails.application.routes.draw do

devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_scope :customer do
post 'guest_sign_in', to: 'public/sessions#guest_sign_in'
end

 namespace :admin do
   root to: "homes#top"

   resources :posts, only: [:index, :show, :destroy] do
     resources :comments, only: [:index, :show, :destroy]
     resources :favorites, only: [:index]
   end
   resources :customers, only: [:index, :show, :edit, :update] do
    get '/comments' => 'comments#all'
    get '/favorites' => 'favorites#all'
    get '/posts' => 'posts#all'
   end
 end

devise_scope :public do
  root to: "public/homes#top"

#   post '/homes/guest_sign_in' => 'public/homes#guest_sign_in'
  get 'about' => 'public/homes#about', as: 'about'
  post 'posts/new' => 'public/posts#create'
  resources :posts, except: [:create], module: 'public' do
    resource :favorites, only: [:create, :destroy]
    get '/comments' => 'comments#index'
    resources :comments, except: [:update, :index]
  end

   resources :customers, only: [:show, :edit, :update], module: 'public' do
       get '/draft' => 'customers#draft'
       get '/comments' => 'comments#all'
       get '/favorites' => 'favorites#all'
       get '/posts' => 'posts#all'
   end
   get 'customers/unsubscribe' => 'public/customers#unsubscribe', as: 'unsubscribe'
   patch 'customers/withdraw' => 'public/customers#withdraw', as: 'withdraw'
end


devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
