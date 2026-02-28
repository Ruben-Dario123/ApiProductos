defmodule HolaApi.Repo.Migrations.CreateProductos do
  use Ecto.Migration

  def change do
    create table(:productos) do
      add :nombre, :string
      add :precio, :float

      timestamps()
    end
  end
end
