# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Slop.Repo.insert!(%Slop.SomeSchema{})
#
# and so on) as they will fail if something goes wrong.
# We recommend using the bang functions (`insert!`, `update!`

alias Slop.Reports
alias Slop.Inventory

{:ok, bun} = Inventory.create_ingredient(%{name: "brioche bun", unit: "pieces"})
{:ok, beef} = Inventory.create_ingredient(%{name: "ground beef", unit: "g"})
{:ok, burger} = Inventory.create_menu_item(%{name: "hamburger"})

{:ok, _} = Inventory.add_ingredient_to_recipe(burger, bun, 1)
{:ok, _} = Inventory.add_ingredient_to_recipe(burger, beef, 100)

# TODO: Investigate nvim-cmp, it seems to break a lot here.
{:ok, _} = Reports.create_purchase(%{quantity: 1000, purchase_date: ~D[2024-03-04], ingredient_id: beef.id})
{:ok, _} = Reports.create_purchase(%{quantity: 10, purchase_date: ~D[2024-03-04], ingredient_id: bun.id})

{:ok, _} = Reports.create_sale(%{month: ~D[2024-03-21], quantity_sold: 8, menu_item_id: burger.id})
