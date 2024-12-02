defmodule SlopWeb.RecipeIngredientController do
  use SlopWeb, :controller

  alias Slop.Inventory

  def index(conn, %{"menu_item_id" => menu_item_id}) do
    recipe = Inventory.get_recipe(menu_item_id)
    render(conn, :index, recipe_ingredients: recipe)
  end

  def create(conn, %{"menu_item_id" => menu_item_id, "recipe_ingredient" => params}) do
    menu_item = Inventory.get_menu_item!(menu_item_id)
    ingredient = Inventory.get_ingredient!(params["ingredient_id"])

    with {:ok, recipe_ingredient} <- 
      Inventory.add_ingredient_to_recipe(menu_item, ingredient, params["quantity"]) do
      conn
      |> put_status(:created)
      |> render(:show, recipe_ingredient: recipe_ingredient)
    end
  end
end
