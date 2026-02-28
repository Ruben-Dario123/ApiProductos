defmodule HolaApi.Repo.Migrations.CreateUsuarios do
  use Ecto.Migration

  def change do
    create table(:usuarios) do
      add :username, :string
      add :password_hash, :string

      timestamps(type: :utc_datetime)
    end
  end
end
