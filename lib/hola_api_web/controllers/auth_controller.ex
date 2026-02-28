defmodule HolaApiWeb.AuthController do
  use HolaApiWeb, :controller
  alias HolaApi.Repo
  alias HolaApi.Cuentas.Usuario
  alias HolaApi.Guardian

  # REGISTRO: Aquí el usuario decide su nombre y clave
  def register(conn, %{"username" => username, "password" => password}) do
    changeset = Usuario.changeset(%Usuario{}, %{username: username, password_hash: password})

    case Repo.insert(changeset) do
      {:ok, usuario} ->
        conn
        |> put_status(:created)
        |> json(%{message: "Usuario #{usuario.username} registrado con éxito"})
      {:error, _changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "No se pudo crear el usuario. ¿Quizás ya existe?"})
    end
  end

  # LOGIN: Busca dinámicamente lo que se registró arriba
  def login(conn, %{"username" => username, "password" => password}) do
    usuario = Repo.get_by(Usuario, username: username)

    # Validamos que el usuario exista y la clave coincida con la guardada
    if usuario && usuario.password_hash == password do
      {:ok, token, _claims} = Guardian.encode_and_sign(usuario)
      json(conn, %{token: token, expires_in: "30 minutes"})
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Usuario o contraseña no coinciden"})
    end
  end
end
