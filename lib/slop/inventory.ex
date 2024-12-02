defmodule Slop.Inventory do
  import Ecto.Query
  alias Slop.Repo
  alias Slop.Inventory.{MenuItem, Ingredient, RecipeIngredient}

  def create_menu_item(attrs \\ %{}) do
    %MenuItem{}
    |> MenuItem.changeset(attrs)
    |> Repo.insert()
  end

  def create_ingredient(attrs \\ %{}) do
    %Ingredient{}
    |> Ingredient.changeset(attrs)
    |> Repo.insert()
  end

  def add_ingredient_to_recipe(%MenuItem{} = menu_item, %Ingredient{} = ingredient, quantity) do
    %RecipeIngredient{}
    |> RecipeIngredient.changeset(%{
      menu_item_id: menu_item.id,
      ingredient_id: ingredient.id,
      quantity: quantity
    })
    |> Repo.insert()
  end

  def get_recipe(menu_item_id) do
    RecipeIngredient
    |> where([ri], ri.menu_item_id == ^menu_item_id)
    |> preload(:ingredient)
    |> Repo.all()
  end

  def list_menu_items do
    MenuItem
    |> preload(recipe_ingredients: :ingredient)
    |> Repo.all()
  end

  def list_ingredients do
    Repo.all(Ingredient)
  end

  def get_menu_item!(id) do
    MenuItem
    |> preload(recipe_ingredients: :ingredient)
    |> Repo.get!(id)
  end

  def get_ingredient!(id) do
    Repo.get!(Ingredient, id)
  end
end
