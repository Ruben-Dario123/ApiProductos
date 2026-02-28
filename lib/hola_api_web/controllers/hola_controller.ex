defmodule HolaApiWeb.HolaController do
  use HolaApiWeb, :controller

  def hola(conn, _params) do
    json(conn, %{mensaje: "qué onda apá, amos a pelear Comales "})
  end

  def wow(conn, _params) do
    json(conn, %{response: "ok"})
  end
end
