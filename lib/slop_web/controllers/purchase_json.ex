defmodule SlopWeb.PurchaseJSON do
  def index(%{purchases: purchases}) do
    %{data: for(purchase <- purchases, do: data(purchase))}
  end

  def show(%{purchase: purchase}) do
    %{data: data(purchase)}
  end

  def data(purchase) do
    %{
      id: purchase.id,
      ingredient: %{
        id: purchase.ingredient.id,
        name: purchase.ingredient.name,
        unit: purchase.ingredient.unit
      },
      quantity: purchase.quantity,
      purchase_date: purchase.purchase_date
    }
  end
end
