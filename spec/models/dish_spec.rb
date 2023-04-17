require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end

  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe 'instance methods' do
    before :each do 
      @chef1 = Chef.create!(name: "Chef1")
      @chef2 = Chef.create!(name: "Chef2")
      @salad = @chef1.dishes.create!(name: "Salad", description: "Leafy Greens")
      @donut = @chef2.dishes.create!(name: "Donut", description: "The Best")
      @lettuce = Ingredient.create!(name: "Lettuce", calories: 100)
      @croutons = Ingredient.create!(name: "Croutons", calories: 200)
      @flour = Ingredient.create!(name: "Flour", calories: 800)
      @sugar = Ingredient.create!(name: "Sugar", calories: 900)
      DishIngredient.create!(dish: @salad, ingredient: @lettuce)
      DishIngredient.create!(dish: @salad, ingredient: @croutons)
      DishIngredient.create!(dish: @donut, ingredient: @flour)
      DishIngredient.create!(dish: @donut, ingredient: @sugar)
    end

    describe '.chef_name' do
      it 'returns the name of the chef' do
        expect(@salad.chef_name).to eq("Chef1")
        expect(@donut.chef_name).to eq("Chef2")
      end
    end

    describe ".total_calories" do
      it 'returns the total calories of the dish' do
        expect(@salad.total_calories).to eq(300)
        expect(@donut.total_calories).to eq(1700)
      end
    end
  end
end