defmodule SlopWeb.ReportJSON do
  def show(%{report: report}) do
    %{
      data: for item <- report do
        %{
          ingredient: %{
            id: item.ingredient.id,
            name: item.ingredient.name,
            unit: item.ingredient.unit
          },
          purchased_quantity: item.purchased_quantity,
          used_quantity: item.used_quantity,
          difference: item.difference
        }
      end
    }
  end
end
