class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  # Action to show all recipes

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  # Action to create new recipe

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(name: params['name'], ingredients: params['ingredients'], cook_time: params['cook_time'])
    redirect to "/recipes/#{@recipe.id}"
  end

  # Action to show single recipe (and button to delete)

  get '/recipes/:id' do
    @new_recipe = Recipe.find(params[:id])
    erb :show
  end

  # Action to edit recipe
  patch '/recipes/:id' do
    @new_recipe = Recipe.find(params[:id])
    @new_recipe.update(name: params['name'], ingredients: params['ingredients'], cook_time: params['cook_time'])
    erb :show
  end

  get '/recipes/:id/edit/?' do
    @new_recipe = Recipe.find(params[:id])
    erb :edit
  end

  #Action to delete recipe
  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    erb :delete
  end


end
