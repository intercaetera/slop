defmodule Slop.Inventory.MenuItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "menu_items" do
    field :name, :string

    has_many :recipe_ingredients, Slop.Inventory.RecipeIngredient
    has_many :ingredients, through: [:recipe_ingredients, :ingredient]
    has_many :sales, Slop.Reports.Sale

    timestamps()
  end

  def changeset(menu_item, attrs) do
    menu_item
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
