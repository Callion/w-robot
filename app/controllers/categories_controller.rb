# frozen_string_literal: true
# Documentation comment
class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to edit_category_path(@category), notice: 'Category was successfully created.' }
        format.json { render :edit, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html do
          redirect_to edit_category_path(@category),
                      notice: 'Category was successfully updated.'
        end
        format.json { render :edit, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json do
          render json: @category.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html do
        redirect_to automations_url,
                    notice: 'Category was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :color, :priority)
  end
end
