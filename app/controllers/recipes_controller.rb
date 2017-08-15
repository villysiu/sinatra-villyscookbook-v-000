 class RecipesController < ApplicationController
  get '/recipes' do
    if logged_in?
      @recipes = Recipe.all
      if @recipes.empty?
        flash[:message] = "The receipe box is currently empty. Please contribute by submitting the first recipe."
        redirect :'/recipes/new'
      else
        erb :'/recipes/show_all_recipes'
      end
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
          @recipe.ingredients << Ingredient.find_or_create_by(name: i[:name].downcase.singularize)
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

  get '/recipes/:id' do
    if logged_in?
      @recipe = Recipe.find(params[:id]) rescue nil
      if @recipe.nil?
        flash[:message] = 'Recipe does not exist'
        redirect '/recipes'
      else
        erb :'/recipes/show_recipe'
      end
    else
      flash[:message] = "You are not logged in"
      redirect "/"
    end
  end

  get '/recipes/:id/edit' do
    if logged_in?
      @recipe = Recipe.find(params[:id]) rescue nil
      if @recipe.nil?
        flash[:message] = 'Recipe does not exist'
        redirect '/recipes'
      elsif @recipe.user==current_user
        erb :'/recipes/edit_recipe'
      else
        flash[:message] = "You cannot edit a recipe created by another user"
        erb :'/recipes/show_recipe'

      end
    else
      flash[:message] = "You are not logged in"
      redirect "/"
    end
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    if @recipe.update(params[:recipe])
      params[:ingredient].each do |i|
        if !i[:name].empty?
          @recipe.ingredients << Ingredient.find_or_create_by(name: i[:name].downcase.singularize)
        end
      end
      @recipe.save
      flash[:message] = "#{@recipe.name} successfully updated"
      redirect "/recipes/#{@recipe.id}"
    else
      flash[:message] = "update failed"
      redirect "/recipes/#{@recipe.id}"
    end
  end


  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    flash[:message] = "#{@recipe.name} deleted"
    redirect "/recipes"
  end

end
