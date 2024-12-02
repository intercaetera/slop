defmodule SlopWeb.IngredientController do
  use SlopWeb, :controller

  alias Slop.Inventory
  alias Slop.Inventory.Ingredient

  def index(conn, _params) do
    ingredients = Inventory.list_ingredients()
    render(conn, :index, ingredients: ingredients)
  end

  def create(conn, %{"ingredient" => ingredient_params}) do
    with {:ok, %Ingredient{} = ingredient} <- Inventory.create_ingredient(ingredient_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/ingredients/#{ingredient}")
      |> render(:show, ingredient: ingredient)
    end
  end

  def show(conn, %{"id" => id}) do
    ingredient = Inventory.get_ingredient!(id)
    render(conn, :show, ingredient: ingredient)
  end
end
