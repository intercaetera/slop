defmodule SlopWeb.PurchaseController do
  use SlopWeb, :controller

  alias Slop.Reports

  def index(conn, %{"year" => year, "month" => month}) do
    {year, _} = Integer.parse(year)
    {month, _} = Integer.parse(month)
    purchases = Reports.list_purchases_by_month(year, month)
    render(conn, :index, purchases: purchases)
  end

  def create(conn, %{"purchase" => purchase_params}) do
    with {:ok, purchase} <- Reports.create_purchase(purchase_params) do
      conn
      |> put_status(:created)
      |> render(:show, purchase: purchase)
    end
  end
end
