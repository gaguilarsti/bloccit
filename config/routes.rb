Rails.application.routes.draw do
  get 'welcome/index'

  get 'welcome/about'

  #root method allows us to designate the default page the app loads when we go to the home URL.
  root 'welcome#index'

end
