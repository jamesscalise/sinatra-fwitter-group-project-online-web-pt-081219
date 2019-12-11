class UsersController < ApplicationController

  get "/signup" do
    erb :'users/create_user'
  end
  
  post '/signup' do
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      binding.pry
      if user.save && params[:username]!="" && params[:email] != ""
        
        redirect '/tweets'
      else
        redirect '/signup'
      end
  end
  
  get "/login" do
    erb :'users/login'
    
    
  end
end
