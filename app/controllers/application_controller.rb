require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

   helpers do
    def logged_in?
      session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

  get '/' do
    @ratings = Rating.all
    @users = User.all
    erb :index
  end

  get '/rating' do
    if session[:user_id] #returns nil if there isn't one
      erb :rating
    else
      redirect "/login"
    end
  end

  post '/rating' do
    user = User.find_by(:id => session[:user_id])
    rating = Rating.new(:user => user, :status => params[:status])
    rating.save
    redirect '/'
  end

  get '/users' do
    @users = User.all
    erb :users
  end
  
  get '/signup' do
    erb :signup
  end

  post '/sign-up' do
    @user = User.new(:username => params[:username], :email => params[:email])
    @user.save
    redirect '/'
  end

  get '/login' do
    erb :login
  end
 
  post '/login' do
     user = User.find_by(:username => params[:username])
     if user
        session[:user_id] = user.id
        redirect "/"
     else
        redirect "/signup"
     end
  end

  get '/rating' do
    erb :rating
    if session[:user_id] #returns nil if there isn't one
      erb :rating
    else
      redirect "/login"
    end
  end
  
  post '/rating' do
    user = User.find_by(:id => session[:user_id])
    rating = Rating.new(:user => user, :status => params[:status])
    ratings.save
    redirect '/'
  end

  get '/logout' do
    session.destroy
    redirect '/login'
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
 
  helpers do
    def logged_in?
      session[:user_id]
    end
 
    def current_user
      User.find(session[:user_id])
    end
  end
end
