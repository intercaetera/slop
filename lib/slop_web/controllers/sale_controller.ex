defmodule SlopWeb.SaleController do
  use SlopWeb, :controller

  alias Slop.Reports

  def index(conn, %{"year" => year, "month" => month}) do
    {year, _} = Integer.parse(year)
    {month, _} = Integer.parse(month)
    sales = Reports.list_sales_by_month(year, month)
    render(conn, :index, sales: sales)
  end

  def create(conn, %{"sale" => sale_params}) do
    with {:ok, sale} <- Reports.create_sale(sale_params) do
      conn
      |> put_status(:created)
      |> render(:show, sale: sale)
    end
  end
end
