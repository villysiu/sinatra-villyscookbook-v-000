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
end
