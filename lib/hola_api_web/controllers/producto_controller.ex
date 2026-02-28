defmodule HolaApiWeb.ProductoController do
  use HolaApiWeb, :controller

  alias HolaApi.Repo
  alias HolaApi.Producto

  # GET /producto - Lista todos los registros
  def index(conn, _params) do
    productos = Repo.all(Producto)
    json(conn, productos)
  end

  # POST /producto - Crea un nuevo registro
  def create(conn, params) do
    changeset = Producto.changeset(%Producto{}, params)

    case Repo.insert(changeset) do
      {:ok, producto} ->
        conn
        |> put_status(:created)
        |> json(producto)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: translate_errors(changeset)})
    end
  end

  # GET /producto/:id - Muestra un registro específico
  def show(conn, %{"id" => id}) do
    case Repo.get(Producto, id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "El producto no existe"})
      producto ->
        json(conn, producto)
    end
  end

  # PUT /producto/:id - Actualiza un registro existente
  def update(conn, %{"id" => id} = params) do
    case Repo.get(Producto, id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "No se puede actualizar: El producto no existe"})

      producto ->
        changeset = Producto.changeset(producto, params)

        case Repo.update(changeset) do
          {:ok, producto_actualizado} ->
            json(conn, producto_actualizado)
          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{errors: translate_errors(changeset)})
        end
    end
  end

  # DELETE /producto/:id - Borra un registro
  def delete(conn, %{"id" => id}) do
    case Repo.get(Producto, id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "No se puede borrar: El producto no existe"})

      producto ->
        case Repo.delete(producto) do
          {:ok, _producto} ->
            send_resp(conn, :no_content, "")
          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{errors: translate_errors(changeset)})
        end
    end
  end

  # Función privada para traducir errores (tu versión actual)
  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
