defmodule Slop.Inventory.RecipeIngredient do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "recipe_ingredients" do
    field :quantity, :decimal

    belongs_to :menu_item, Slop.Inventory.MenuItem
    belongs_to :ingredient, Slop.Inventory.Ingredient

    timestamps()
  end

  def changeset(recipe_ingredient, attrs) do
    recipe_ingredient
    |> cast(attrs, [:quantity, :menu_item_id, :ingredient_id])
    |> validate_required([:quantity, :menu_item_id, :ingredient_id])
    |> validate_number(:quantity, greater_than: 0)
    |> foreign_key_constraint(:menu_item_id)
    |> foreign_key_constraint(:ingredient_id)
    |> unique_constraint([:menu_item_id, :ingredient_id])
  end 
end
