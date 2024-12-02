defmodule Slop.Repo do
  use Ecto.Repo,
    otp_app: :slop,
    adapter: Ecto.Adapters.SQLite3
end
