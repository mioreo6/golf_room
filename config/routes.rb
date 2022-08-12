Rails.application.routes.draw do

 namespace :admin do
   root to: "homes#top"
   resources :posts, only: [:index, :show, :destroy] do
     resources :comments, only: [:index, :show, :destroy]
     resources :favorites, only: [:index]
   end
   resources :customers, only: [:index, :show, :edit, :update]
 end

  namespace :public do
    get 'comments/index'
    get 'comments/new'
    get 'comments/create'
    get 'comments/show'
  end
  namespace :public do
    get 'posts/index'
    get 'posts/new'
    get 'posts/create'
    get 'posts/show'
    get 'posts/edit'
    get 'posts/destroy'
  end
  namespace :public do
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
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
