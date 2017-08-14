class RecipesController < ApplicationController
  get '/recipes' do
    if logged_in?
      @recipes = Recipe.all
      erb :'/recipes/show_all_recipes'
    else
      flash[:message] = "You are not logged in"
      redirect "/"
    end
  end
  get '/recipes/new' do
    if logged_in?
      erb :'/recipes/create_recipe'
    else
      flash[:message] = "You are not logged in"
      redirect "/"
    end
  end

  post '/recipes/new' do

  end

end
