class Chef < ApplicationRecord
  validates_presence_of :name
  has_many :dishes
  has_many :ingredients, through: :dishes

  def unique_ingredients
    ingredients.distinct
  end

  def ingredients_names
    ingredients.distinct.pluck(:name).to_sentence
  end
end