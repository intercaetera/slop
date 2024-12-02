defmodule Slop.Reports do
  import Ecto.Query
  alias Slop.Repo
  alias Slop.Reports.{Purchase, Sale}
  alias Slop.Inventory

  def create_purchase(attrs \\ %{}) do
    %Purchase{}
    |> Purchase.changeset(attrs)
    |> Repo.insert()
  end

  def list_purchases_by_month(year, month) do
    start_date = Date.new!(year, month, 1)
    end_date = Date.add(start_date, Date.days_in_month(start_date))

    Purchase
    |> where([p], p.purchase_date >= ^start_date and p.purchase_date < ^end_date)
    |> preload(:ingredient)
    |> Repo.all()
  end

  def create_sale(attrs \\ %{}) do
    %Sale{}
    |> Sale.changeset(attrs)
    |> Repo.insert()
  end

  def list_sales_by_month(year, month) do
    date = Date.new!(year, month, 1)
    
    Sale
    |> where([s], s.month == ^date)
    |> preload(menu_item: [recipe_ingredients: :ingredient])
    |> Repo.all()
  end

  def generate_monthly_report(year, month) do
    purchases = list_purchases_by_month(year, month)
    sales = list_sales_by_month(year, month)

    theoretical_usage = 
      Enum.reduce(sales, %{}, fn sale, acc ->
        Enum.reduce(sale.menu_item.recipe_ingredients, acc, fn recipe_ingredient, inner_acc ->
          ingredient = recipe_ingredient.ingredient
          used_quantity = Decimal.mult(recipe_ingredient.quantity, sale.quantity_sold)

          Map.update(inner_acc, ingredient.id, used_quantity, &Decimal.add(&1, used_quantity))
        end)
      end)

    purchases_by_ingredient = 
      Enum.reduce(purchases, %{}, fn purchase, acc ->
        Map.update(acc, purchase.ingredient_id, purchase.quantity, &Decimal.add(&1, purchase.quantity))
      end)

    all_ingredient_ids = MapSet.union(
      MapSet.new(Map.keys(theoretical_usage)),
      MapSet.new(Map.keys(purchases_by_ingredient))
    )

    Enum.map(all_ingredient_ids, fn ingredient_id ->
      ingredient = Inventory.get_ingredient!(ingredient_id)
      purchased = Map.get(purchases_by_ingredient, ingredient_id, Decimal.new(0))
      used = Map.get(theoretical_usage, ingredient_id, Decimal.new(0))
      difference = Decimal.sub(purchased, used)

      %{
        ingredient: ingredient,
        purchased_quantity: purchased,
        used_quantity: used,
        difference: difference
      }
    end)
  end
end
