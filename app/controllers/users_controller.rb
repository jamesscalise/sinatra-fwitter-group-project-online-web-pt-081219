class UsersController < ApplicationController

  get "/signup" do

      if logged_in?
        redirect '/tweets'
      else
        erb :'users/create_user'
      end

    
      erb :'users/create_user'
  end
  
  post '/signup' do
      
      user = User.new(username: params[:username], email: params[:email], password: params[:password])

   
      if user.save && params[:username]!="" && params[:email] != ""
        
        redirect '/tweets'
      else
        redirect '/signup'
      end
  end
  
  get "/login" do
    erb :'users/login'
    

  end
  
  post "/login" do
    user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect "/tweets"
  else
    redirect "/login"
  end
  end
  
  post "/login" do
    user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect "/tweets"
  else
    redirect "/login"
  end
  end
  
   get "/logout" do
     session.clear
     redirect '/'
   end
end
