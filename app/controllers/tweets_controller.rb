class TweetsController < ApplicationController
  get '/tweets' do

    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end

    @tweets = Tweet.all
    erb :'tweets/tweets'

  end
  
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user: current_user)
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
        if @tweet.user != current_user
          redirect "tweets/#{params[:id]}"
        else
          erb :'tweets/edit_tweet'
        end
    end
  end
  
  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if !params[:content].empty?
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{params[:id]}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end
  
  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && @tweet.user == current_user
      @tweet.delete
    end
    redirect '/tweets'
  end

end
