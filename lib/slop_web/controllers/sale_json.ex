defmodule SlopWeb.SaleJSON do
  def index(%{sales: sales}) do
    %{data: for(sale <- sales, do: data(sale))}
  end

  def show(%{sale: sale}) do
    %{data: data(sale)}
  end

  def data(sale) do
    %{
      id: sale.id,
      menu_item: %{
        id: sale.menu_item.id,
        name: sale.menu_item.name,
      },
      quantity_sold: sale.quantity_sold,
      month: sale.month,
    }
  end
end
