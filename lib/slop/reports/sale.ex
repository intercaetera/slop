defmodule Slop.Reports.Sale do
 use Ecto.Schema
 import Ecto.Changeset

 @primary_key {:id, Ecto.UUID, autogenerate: true}
 @foreign_key_type Ecto.UUID
 schema "sales" do
   field :month, :date
   field :quantity_sold, :integer

   belongs_to :menu_item, Slop.Inventory.MenuItem

   timestamps()
 end

 def changeset(sale, attrs) do
   sale
   |> cast(attrs, [:month, :quantity_sold, :menu_item_id])
   |> validate_required([:month, :quantity_sold, :menu_item_id])
   |> validate_number(:quantity_sold, greater_than: 0)
   |> foreign_key_constraint(:menu_item_id)
   |> update_change(:month, &Date.beginning_of_month/1)
 end
end
