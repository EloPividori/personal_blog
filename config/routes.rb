Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "blog_posts#index"
  get "blog_posts/new", to: "blog_posts#new", as: "new_blog_post"
  get "blog_posts/:id/edit", to: "blog_posts#edit"
  patch "blog_posts/:id", to: "blog_posts#update"
  get "/blog_posts/:id", to: "blog_posts#show", as: "blog_post"
  post "blog_posts", to: "blog_posts#create"
end
