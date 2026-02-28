defmodule HolaApi.Producto do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :nombre, :precio, :inserted_at, :updated_at]}
  schema "productos" do
    field :nombre, :string
    field :precio, :float

    timestamps()
  end

  def changeset(producto, attrs) do
    producto
    |> cast(attrs, [:nombre, :precio])
    |> validate_required([:nombre, :precio])
  end
end
