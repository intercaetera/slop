defmodule Slop.Repo.Migrations.DatabaseSetup do
  use Ecto.Migration

  def change do
    create table(:ingredients, primary_key: false) do
      add :id, :string, primary_key: true
      add :name, :string, null: false
      add :unit, :string, null: false

      timestamps()
    end

    create unique_index(:ingredients, [:name])

    create table(:menu_items, primary_key: false) do
      add :id, :string, primary_key: true
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:menu_items, [:name])

    create table(:recipe_ingredients, primary_key: false) do
      add :id, :string, primary_key: true
      add :menu_item_id, references(:menu_items, type: :string, on_delete: :delete_all), null: false
      add :ingredient_id, references(:ingredients, type: :string, on_delete: :restrict), null: false
      add :quantity, :decimal, null: false

      timestamps()
    end

    create index(:recipe_ingredients, [:menu_item_id])
    create index(:recipe_ingredients, [:ingredient_id])
    create unique_index(:recipe_ingredients, [:menu_item_id, :ingredient_id])

    create table(:purchases, primary_key: false) do
      add :id, :string, primary_key: true
      add :ingredient_id, references(:ingredients, type: :string, on_delete: :restrict), null: false
      add :quantity, :decimal, null: false
      add :purchase_date, :date, null: false

      timestamps()
    end

    create index(:purchases, [:purchase_date])
    create index(:purchases, [:ingredient_id])

    create table(:sales, primary_key: false) do
      add :id, :string, primary_key: true
      add :menu_item_id, references(:menu_items, type: :string, on_delete: :restrict), null: false
      add :month, :date, null: false
      add :quantity_sold, :integer, null: false

      timestamps()
    end

    create index(:sales, [:month])
    create index(:sales, [:menu_item_id])
  end
end
