defmodule HolaApi.Repo do
  # Define el repositorio de la aplicación
  # El Repo es el encargado de comunicarse con la base de datos
  # Todas las consultas (insert, select, update, delete) pasan por aquí
  use Ecto.Repo,
    # Nombre de la aplicación OTP
    # Se usa para leer la configuración desde config/*.exs
    otp_app: :hola_api,

    # Adaptador de base de datos
    # En este caso se utiliza SQLite3
    adapter: Ecto.Adapters.SQLite3
end
