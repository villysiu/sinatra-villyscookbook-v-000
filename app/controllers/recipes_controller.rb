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
    @recipe = Recipe.new(params[:recipe])
    @recipe.user = current_user

    if @recipe.valid?
      params[:ingredient].each do |i|
        if !i[:name].empty?
          @recipe.ingredients << i.find_or_create(name: i[:name])
        end
      end
      @recipe.save
      current_user.recipes << @recipe
      flash[:message] = "#{@recipe.name} successfully created"
      redirect "/recipes/#{@recipe.id}"
    else
      erb :'/recipes/create_recipe'
    end
  end

end
