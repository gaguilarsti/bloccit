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

  #shallow nesting of comments solely under posts
  # used an empty [] because we don't want to create any /posts/id routes, just posts/:post_id/comments routes.
  resources :posts, only: [] do
    #For right now, we are only going to show comments within a posts show view and not allow them to edit, only create and delete.
    resources :comments, only: [:create, :destroy]
  end

  #
  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  # removed 'get "welcome/index"' because we declared it as the root view.
  # modified the about route to allow users to visit /about, rather than /welcome/about.
  get 'about' => 'welcome#about'

  #root method allows us to designate the default page the app loads when we go to the home URL.
  root 'welcome#index'

end
