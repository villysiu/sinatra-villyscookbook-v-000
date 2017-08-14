class UsersController < ApplicationController

  get '/users/login' do
    redirect '/'
  end

  post '/users/login' do
    @current_user = User.find_by(:name => params[:name])

    session[:id] = @current_user.id
    redirect '/recipes'
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
    redirect "/recipes"
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
end
