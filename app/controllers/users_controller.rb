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
    erb :'/users/signup'
  end

  post '/users/signup' do
    @user = User.create(params[:user])
    redirect "/recipes"
  end
end
