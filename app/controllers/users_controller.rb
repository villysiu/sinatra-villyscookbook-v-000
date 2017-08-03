class UsersController < ApplicationController
  get 'users/login' do
    redirect '/'
  end

  post '/users/login' do

  end
end
