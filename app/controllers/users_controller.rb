class UsersController < ApplicationController

  get "/signup" do
      if logged_in?
        redirect '/tweets'
      else
        erb :'users/create_user'
      end
  end
  
  post '/signup' do
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if user.save && params[:username]!="" && params[:email] != ""
        session[:user_id] = user.id
        redirect '/tweets'

      else
        redirect '/signup'
      end
  end
  
  get "/login" do
    if !logged_in?
      erb :'users/login'
    else
      redirect "/tweets"
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
     redirect '/login'
   end
   
   get "/users/:slug" do
     @user = User.find_by_slug(params[:slug])
     @tweets = @user.tweets
     erb :show
   end
end
