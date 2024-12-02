defmodule SlopWeb.RecipeIngredientJSON do
  def index(%{recipe_ingredients: recipe_ingredients}) do
    %{data: for(ri <- recipe_ingredients, do: data(ri))}
  end

  def show(%{recipe_ingredient: recipe_ingredient}) do
    %{data: data(recipe_ingredient)}
  end

  def data(recipe_ingredient) do
    %{
      id: recipe_ingredient.id,
      ingredient: %{
        id: recipe_ingredient.ingredient.id,
        name: recipe_ingredient.ingredient.name,
        unit: recipe_ingredient.ingredient.unit
      },
      quantity: recipe_ingredient.quantity
    }
  end
end
