Rails.application.routes.draw do


  namespace :admin do
    get 'favorites/index'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :admin do
    get 'comments/index'
    get 'comments/show'
  end
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  namespace :admin do
    get 'homes/top'
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
