Rails.application.routes.draw do
  #initially, when we generated Posts, it included the items commented out below but then we switched to the resources method.
  #get 'posts/index'
  #get 'posts/show'
  #get 'posts/new'
  #get 'posts/edit'

  # calling the resources method and passing a symbol.
  #instructs Rails to create post routes for creating, updating, viewing and deleting instances of Post.
  # we pass resources :posts to the resources :topics block.  This nests the post routes under the topic routes.
  resources :topics do
    resources :posts, except: [:index]
  end

  #creating only new and create routes for users.
  resources :users, only: [:new, :create]

  # removed 'get "welcome/index"' because we declared it as the root view.
  # modified the about route to allow users to visit /about, rather than /welcome/about.
  get 'about' => 'welcome#about'

  #root method allows us to designate the default page the app loads when we go to the home URL.
  root 'welcome#index'

end
