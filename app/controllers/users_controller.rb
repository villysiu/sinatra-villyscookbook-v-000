class UsersController < ApplicationController

  get '/users/login' do
    redirect '/'
  end

  post '/users/login' do
    @current_user = User.find_by(:name => params[:name])
    if @current_user.nil?
      flash[:message] = "User does not exist"
      redirect '/'
    elsif @current_user.authenticate(params[:password]) == false
      flash[:message] = "Password is incorrect"
      redirect '/'
    else
      session[:id] = @current_user.id
      redirect '/recipes'
    end
  end

  get '/users/signup' do
    if logged_in?
      redirect '/recipes'
    else
      erb :'/users/signup'
    end
  end

  post '/users/signup' do
    @user = User.create(params[:user])
    if @user.valid?
      session[:id] = @user.id
      redirect '/recipes'
    else
      erb :'/users/signup'
    end
  end

  get '/users/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show_user_recipes'
    else
      flash[:message] = "You are not logged in"
      redirect "/"
    end
  end

  post '/logout' do
    if logged_in?
      session.clear
      flash[:message] = "you are logged out"
    end
    erb :index
  end
end
