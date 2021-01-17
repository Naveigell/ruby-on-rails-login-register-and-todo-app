Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/login', to: 'user/user#login_page'
  post '/login', to: 'user/user#login'
  post '/register', to: 'user/user#register'

  post '/todo/create', to: 'todo/todo#create'
  post '/todo/update', to: 'todo/todo#update'
  get '/todo/:id/delete', to: 'todo/todo#delete'
  get '/todo/:id/edit', to: 'todo/todo#edit'

  get '/', to: 'home/home#home'
  get '/logout', to: 'user/user#logout'

  get '/error/:code', to: 'error/error#error'

  get '*path', to: 'error/error#error'

  root 'home/home#home'
end
