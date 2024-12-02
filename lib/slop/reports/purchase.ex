defmodule Slop.Reports.Purchase do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "purchases" do
    field :quantity, :decimal
    field :purchase_date, :date

    belongs_to :ingredient, Slop.Inventory.Ingredient

    timestamps()
  end

  def changeset(purchase, attrs) do
   purchase
   |> cast(attrs, [:quantity, :purchase_date, :ingredient_id])
   |> validate_required([:quantity, :purchase_date, :ingredient_id])
   |> validate_number(:quantity, greater_than: 0)
   |> foreign_key_constraint(:ingredient_id)
 end  
end
