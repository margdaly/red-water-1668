require "rails_helper"

RSpec.describe "Dish Show Page" do
  describe 'As a visitor' do
    before :each do
      @chef1 = Chef.create!(name: "Chef1")
      @chef2 = Chef.create!(name: "Chef2")
      @salad = @chef1.dishes.create!(name: "Salad", description: "Leafy Greens")
      @donut = @chef2.dishes.create!(name: "Donut", description: "The Best")
      @lettuce = Ingredient.create!(name: "Lettuce", calories: 100)
      @croutons = Ingredient.create!(name: "Croutons", calories: 200)
      @carrots = Ingredient.create!(name: "Carrots", calories: 150)
      @flour = Ingredient.create!(name: "Flour", calories: 800)
      @sugar = Ingredient.create!(name: "Sugar", calories: 900)
      @butter = Ingredient.create!(name: "Butter", calories: 700)
      DishIngredient.create!(dish: @salad, ingredient: @lettuce)
      DishIngredient.create!(dish: @salad, ingredient: @croutons)
      DishIngredient.create!(dish: @donut, ingredient: @flour)
      DishIngredient.create!(dish: @donut, ingredient: @sugar)
    end

    it "I see the dish's name and description" do
      visit dish_path(@salad)
      expect(page).to have_content(@salad.name)
      expect(page).to have_content(@salad.description)
      expect(page).to_not have_content(@donut.name)
      expect(page).to_not have_content(@donut.description)
    end
    
    it "And I see a list of ingredients for that dish
      and a total calorie count for that dish" do
      visit dish_path(@donut)
      within "#ingredients-#{@flour.id}" do
        expect(page).to have_content(@flour.name)
        expect(page).to have_content(@flour.calories)
        expect(page).to_not have_content(@sugar.name)
        expect(page).to_not have_content(@sugar.calories)
      end

      within "#ingredients-#{@sugar.id}" do
        expect(page).to have_content(@sugar.name)
        expect(page).to have_content(@sugar.calories)
        expect(page).to_not have_content(@flour.name)
        expect(page).to_not have_content(@flour.calories)
      end

      expect(page).to have_content("Donut's Total Calories: 1700")
      expect(page).to_not have_content("Salad's Total Calories: 300")

      visit dish_path(@salad)
      within "#ingredients-#{@lettuce.id}" do
        expect(page).to have_content(@lettuce.name)
        expect(page).to have_content(@lettuce.calories)
        expect(page).to_not have_content(@croutons.name)
        expect(page).to_not have_content(@croutons.calories)
      end

      within "#ingredients-#{@croutons.id}" do
        expect(page).to have_content(@croutons.name)
        expect(page).to have_content(@croutons.calories)
        expect(page).to_not have_content(@lettuce.name)
        expect(page).to_not have_content(@lettuce.calories)
      end

      expect(page).to have_content("Salad's Total Calories: 300")
      expect(page).to_not have_content("Donut's Total Calories: 1700")
    end
      
    it "And I see the chef's name" do
      visit dish_path(@donut)

      expect(page).to have_content("Dish By: Chef2")
      expect(page).to_not have_content("Dish By: Chef1")
      visit dish_path(@salad)

      expect(page).to have_content("Dish By: Chef1")
      expect(page).to_not have_content("Dish By: Chef2")
    end

    describe 'I see a form' do 
      xit "has form to add an ingredient to this Dish" do
        visit dish_path(@donut)
        within "#add-ingredient" do
          expect(page).to have_field(:ingredient_id)
          expect(page).to have_field("Sumbit")
          expect(page).to have_content("Add Ingredient to Donut")
        end

        visit dish_path(@salad)
        within "#add-ingredient" do
          expect(page).to have_field(:ingredient_id)
          expect(page).to have_field("Sumbit")
          expect(page).to have_content("Add Ingredient to Salad")
        end
      end

      it "When I fill in the form with the ID of an Ingredient, 
          and click Submit, I am redirected to that dish's show page,
          And I see that ingredient is now listed." do
        visit dish_path(@donut)
        expect(page).to_not have_content(@butter.name)

        fill_in :ingredient_id, with: @butter.id
        click_on("Submit")

        expect(current_path).to eq(dish_path(@donut))
        within "#ingredients-#{@butter.id}" do
          expect(page).to have_content(@butter.name)
        end
        expect(page).to have_content("Donut's Total Calories: 2400")

        visit dish_path(@salad)
        expect(page).to_not have_content(@carrots.name)

        fill_in :ingredient_id, with: @carrots.id
        click_on("Submit")

        expect(current_path).to eq(dish_path(@salad))
        within "#ingredients-#{@carrots.id}" do
          expect(page).to have_content(@carrots.name)
        end
        expect(page).to have_content("Salad's Total Calories: 450")
      end
    end
  end
end