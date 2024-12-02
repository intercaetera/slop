defmodule Slop.Inventory.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "ingredients" do
    field :name, :string
    field :unit, :string

    has_many :recipe_ingredients, Slop.Inventory.RecipeIngredient
    has_many :menu_items, through: [:recipe_ingredients, :menu_item]
    has_many :purchases, Slop.Reports.Purchase
    
    timestamps()
  end

  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:name, :unit])
    |> validate_required([:name, :unit])
    |> unique_constraint(:name)
    |> validate_inclusion(:unit, ~w(g ml pieces))
  end
end
