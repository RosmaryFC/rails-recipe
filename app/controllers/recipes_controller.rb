class RecipesController < ApplicationController

  #GET /recipes
  def index
    @recipes = Recipe.where(:category_id => params[:category_id])
    if @recipes.empty?
      render :json => {
          :error => 'Recipes list for this Category is empty!'
      }
    else
      render :json => {
          :response => 'List all recipes for Category',
          :data => @recipes
      }
    end
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)
    if Category.exists?(@recipe.category_id)
      if @recipe.save
        render :json => {
            :response => 'create the recipe',
            :data => @recipe
        }
      else
        render :json => {
            :error => 'cannot save the recipe'
        }
      end
    else
      render :json => {
          :error => 'category does not exist, cannot save the recipe'
      }
    end
  end

  # GET recipes/:id
  def show
    @show_recipe = Recipe.where(:category_id => params[:category_id]).find_by_id(params[:id])
    if @show_recipe.present?
      render :json => {
          :response => 'show the recipe',
          :data => @show_recipe
      }
    else
      render :json => {
          :error => 'Cannot show selected recipe because either recipe or category does not exist'
      }
    end
  end

  # PUT recipes/:id
  def update
    @update_recipe = Recipe.where(:category_id => params[:category_id]).find_by_id(params[:id])
    if Category.exists?(params[:category_id])
      if @update_recipe.present?
        @update_recipe.update(recipe_params)
        render :json => {
            :response => 'updated the recipe',
            :data => @update_recipe
        }
      else
        render :json => {
            :error => 'Cannot update recipe because it does not exist'
        }
      end
    else
      render :json => {
          :error => 'Cannot update recipe because Category does not exist'
      }
    end
  end

  #DELETE /recipes/:id
  def destroy
    @destroy_recipe = Recipe.where(:category_id => params[:category_id]).find_by_id(params[:id])
    if Category.exists?(params[:category_id])
      if @destroy_recipe.present?
        @destroy_recipe.destroy
        render :json => {
            :response => 'destroyed the recipe',
            :data => @destroy_recipe
        }
      else
        render :json => {
            :error => 'Cannot destroy recipe because it does not exist'
        }
      end
    else
      render :json => {
          :error => 'Cannot destroy recipe because Category does not exist'
      }
    end
  end

  private
  def recipe_params
    # whitelist params
    params.permit(:name, :ingredients, :directions, :notes, :tags, :category_id )
  end
end
