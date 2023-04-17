require 'rails_helper'

RSpec.describe 'Chef Show Page' do
  describe 'As a visitor' do
    before :each do
      @chef1 = Chef.create!(name: "Chef1")
      @chef2 = Chef.create!(name: "Chef2")
      @salad = @chef1.dishes.create!(name: "Salad", description: "Leafy Greens")
      @donut = @chef2.dishes.create!(name: "Donut", description: "The Best")
      @frosting = @chef2.dishes.create!(name: "Frosting", description: "The Absolute Best")
      @lettuce = Ingredient.create!(name: "Lettuce", calories: 100)
      @croutons = Ingredient.create!(name: "Croutons", calories: 200)
      @flour = Ingredient.create!(name: "Flour", calories: 800)
      @sugar = Ingredient.create!(name: "Sugar", calories: 900)
      @butter = Ingredient.create!(name: "Butter", calories: 700)
      DishIngredient.create!(dish: @salad, ingredient: @lettuce)
      DishIngredient.create!(dish: @salad, ingredient: @croutons)
      DishIngredient.create!(dish: @donut, ingredient: @flour)
      DishIngredient.create!(dish: @donut, ingredient: @sugar)
      DishIngredient.create!(dish: @frosting, ingredient: @butter)
      DishIngredient.create!(dish: @frosting, ingredient: @sugar)
    end

    it 'I see a link to view a list of all ingredients that this chef uses in their dishes.' do
      visit chef_path(@chef2)
      expect(page).to have_link("View All Ingredients")
      visit chef_path(@chef1)
      expect(page).to have_link("View All Ingredients")
    end

    it "When I click on that link
    I'm taken to a chef's ingredients index page
    and I can see a unique list of names of all the ingredients that this chef uses" do
      visit chef_path(@chef2)
      click_on "View All Ingredients"
      expect(current_path).to eq(chef_ingredients_path(@chef2))
      expect(page).to have_content("Flour, Sugar, and Butter")
    end
  end
end