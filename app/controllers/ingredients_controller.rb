class IngredientsController < ApplicationController
  def index
    require 'pry'; binding.pry
    @chef = Chef.find(params[:id])
  end
end