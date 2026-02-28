defmodule HolaApiWeb.UsuarioJSON do
  alias HolaApi.Cuentas.Usuario

  @doc """
  Renders a list of usuarios.
  """
  def index(%{usuarios: usuarios}) do
    %{data: for(usuario <- usuarios, do: data(usuario))}
  end

  @doc """
  Renders a single usuario.
  """
  def show(%{usuario: usuario}) do
    %{data: data(usuario)}
  end

  defp data(%Usuario{} = usuario) do
    %{
      id: usuario.id,
      username: usuario.username,
      password_hash: usuario.password_hash
    }
  end
end
