defmodule HolaApiWeb.Router do
  use HolaApiWeb, :router

  # --- 1. LOS FILTROS ---
  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug HolaApi.Guardian.Pipeline
  end

  # --- 2. ZONA PÚBLICA (Sin Token) ---
  # Aquí va lo que cualquiera puede usar (Login, Registro y ver el catálogo)
  scope "/", HolaApiWeb do
    pipe_through :api

    post "/auth/register", AuthController, :register
    post "/auth/login", AuthController, :login
    get "/producto", ProductoController, :index
    get "/producto/:id", ProductoController, :show
  end

  # --- 3. ZONA PRIVADA (Uso exclusivo del psicólogo con Token) ---
  # Todo lo que modifique datos va aquí adentro
  scope "/", HolaApiWeb do
    pipe_through [:api, :jwt_authenticated] # <-- Este es el guardia de seguridad

    post "/producto", ProductoController, :create
    put "/producto/:id", ProductoController, :update
    delete "/producto/:id", ProductoController, :delete
  end
end
