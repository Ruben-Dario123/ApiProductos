defmodule HolaApiWeb.UsuarioController do
  use HolaApiWeb, :controller

  alias HolaApi.Cuentas
  alias HolaApi.Cuentas.Usuario

  action_fallback HolaApiWeb.FallbackController

  def index(conn, _params) do
    usuarios = Cuentas.list_usuarios()
    render(conn, :index, usuarios: usuarios)
  end

  def create(conn, %{"usuario" => usuario_params}) do
    with {:ok, %Usuario{} = usuario} <- Cuentas.create_usuario(usuario_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/usuarios/#{usuario}")
      |> render(:show, usuario: usuario)
    end
  end

  def show(conn, %{"id" => id}) do
    usuario = Cuentas.get_usuario!(id)
    render(conn, :show, usuario: usuario)
  end

  def update(conn, %{"id" => id, "usuario" => usuario_params}) do
    usuario = Cuentas.get_usuario!(id)

    with {:ok, %Usuario{} = usuario} <- Cuentas.update_usuario(usuario, usuario_params) do
      render(conn, :show, usuario: usuario)
    end
  end

  def delete(conn, %{"id" => id}) do
    usuario = Cuentas.get_usuario!(id)

    with {:ok, %Usuario{}} <- Cuentas.delete_usuario(usuario) do
      send_resp(conn, :no_content, "")
    end
  end
end
