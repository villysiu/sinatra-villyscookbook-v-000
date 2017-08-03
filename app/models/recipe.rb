class Recipe < ActiveRecord::Base
  validates_presence_of :name, :user_id

  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
end
