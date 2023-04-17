class DishIngredientsController < ApplicationController
  def create 
    @dish = Dish.find(params[:dish_id])
    @ingredient = Ingredient.find(params[:ingredient_id])
    DishIngredient.create!(dish: @dish, ingredient: @ingredient)
    redirect_to dish_path(@dish)
  end

  private
  def dish_ingredient_params
    params.require(:dish_ingredient).permit(:dish_id, :ingredient_id)
  end
end