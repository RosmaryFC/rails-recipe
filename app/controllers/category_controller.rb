class CategoryController < ApplicationController

  # GET /category
  def index
    @categories = Category.all
    if @categories.empty?
      render :json => {
          :error => 'Categories list is empty!'
      }
    else
      render :json => {
          :response => 'List all categories',
          :data => @categories
      }
    end
  end

  # POST /category
  def create
    @category = Category.new(category_params)
    if @category.save
      render :json => {
          :response => 'create the category',
          :data => @category
      }
    else
      render :json => {
          :error => 'cannot save the category',
      }
    end

  end

  # GET /category/:id
  def show
    @show_category = Category.find_by_id(params[:id])
    if @show_category.present?
      render :json => {
          :response => 'show the category',
          :data => @show_category
      }
    else
      render :json => {
          :error => 'Cannot show selected category because it does not exist'
      }
    end
  end

  #PUT /category/:id
  def update
    @update_category = Category.find_by_id(params[:id])
    if @update_category.present?
      @update_category.update(category_params)
      render :json => {
          :response => 'updated the category',
          :data => @update_category
      }
    else
      render :json => {
          :error => 'Cannot update selected category because it does not exist'
      }
    end
  end

  #DELETE /category/:id
  def destroy
    @find_category = Category.find_by_id(params[:id])
    if @find_category.present?
      @find_category.destroy
      render :json => {
          :response => 'deleted the category',
          :data => @find_category
      }
    else
      render :json => {
          :error => 'Cannot destroy selected category because it does not exist'
      }
    end
  end

  private

  def category_params
    # whitelist params
    params.permit(:title, :description, :created_by)
  end

end
