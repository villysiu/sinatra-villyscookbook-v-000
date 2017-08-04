class RecipesController < ApplicationController
  get '/recipes' do
    erb :'/recipes/show_all_recipes'
  end
end
