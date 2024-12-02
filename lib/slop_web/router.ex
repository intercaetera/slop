defmodule SlopWeb.Router do
  use SlopWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SlopWeb do
    pipe_through :api

    # Inventory
    resources "/menu-items", MenuItemController, only: [:index, :create, :show] do
      resources "/recipe-ingredients", RecipeIngredientController, only: [:index, :create, :delete]
    end
    resources "/ingredients", IngredientController, only: [:index, :create, :show]

    # Reports
    resources "/purchases", PurchaseController, only: [:create, :index]
    resources "/sales", SaleController, only: [:create, :index]
    get "/reports/:year/:month", ReportController, :show
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:slop, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: SlopWeb.Telemetry
    end
  end
end
