require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
    it {should have_many(:ingredients).through(:dishes)}
  end

  describe 'instance methods' do
    before :each do
      @chef2 = Chef.create!(name: "Chef2")
      @donut = @chef2.dishes.create!(name: "Donut", description: "The Best")
      @frosting = @chef2.dishes.create!(name: "Frosting", description: "The Absolute Best")
      @flour = Ingredient.create!(name: "Flour", calories: 800)
      @sugar = Ingredient.create!(name: "Sugar", calories: 900)
      @butter = Ingredient.create!(name: "Butter", calories: 700)
      DishIngredient.create!(dish: @donut, ingredient: @flour)
      DishIngredient.create!(dish: @donut, ingredient: @sugar)
      DishIngredient.create!(dish: @frosting, ingredient: @butter)
      DishIngredient.create!(dish: @frosting, ingredient: @sugar)
    end

    describe '.unique_ingredients' do
      it 'returns a unique list of ingredients' do
        expect(@chef2.unique_ingredients).to eq([@flour, @sugar, @butter])
      end
    end
  end
end