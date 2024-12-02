defmodule SlopWeb.MenuItemController do
  use SlopWeb, :controller

  alias Slop.Inventory
  alias Slop.Inventory.MenuItem

  def index(conn, _params) do
    menu_items = Inventory.list_menu_items()
    render(conn, :index, menu_items: menu_items)
  end

  def create(conn, %{"menu_item" => menu_item_params}) do
    with {:ok, %MenuItem{} = menu_item} <- Inventory.create_menu_item(menu_item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/menu-items/#{menu_item}")
      |> render(:show, menu_item: menu_item)
    end
  end

  def show(conn, %{"id" => id}) do
    menu_item = Inventory.get_menu_item!(id)
    render(conn, :show, menu_item: menu_item)
  end
end
