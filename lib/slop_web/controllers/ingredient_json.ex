defmodule SlopWeb.IngredientJSON do
  def index(%{ingredients: ingredients}) do
    %{data: for(ingredient <- ingredients, do: data(ingredient))}
  end

  def show(%{ingredient: ingredient}) do
    %{data: data(ingredient)}
  end

  def data(ingredient) do
    %{
      id: ingredient.id,
      name: ingredient.name,
      unit: ingredient.unit
    }
  end
end
