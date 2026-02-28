defmodule HolaApi.CuentasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HolaApi.Cuentas` context.
  """

  @doc """
  Generate a usuario.
  """
  def usuario_fixture(attrs \\ %{}) do
    {:ok, usuario} =
      attrs
      |> Enum.into(%{
        password_hash: "some password_hash",
        username: "some username"
      })
      |> HolaApi.Cuentas.create_usuario()

    usuario
  end
end
