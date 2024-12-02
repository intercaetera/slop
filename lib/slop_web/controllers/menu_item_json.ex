defmodule SlopWeb.MenuItemJSON do
  def index(%{menu_items: menu_items}) do
    %{data: for(menu_item <- menu_items, do: data(menu_item))}
  end

  def show(%{menu_item: menu_item}) do
    %{data: data(menu_item)}
  end

  def data(menu_item) do
    %{
      id: menu_item.id,
      name: menu_item.name,
      recipe_ingredients: for(ri <- menu_item.recipe_ingredients, do: %{
        id: ri.id,
        ingredient: %{
          id: ri.ingredient.id,
          name: ri.ingredient.name,
          unit: ri.ingredient.unit
        },
        quantity: ri.quantity
      })
    }
  end
end
