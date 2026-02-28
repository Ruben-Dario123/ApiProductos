defmodule HolaApi.Application do
  # Módulo principal de la aplicación OTP
  # Se encarga de iniciar y supervisar los procesos principales
  use Application

  # Se desactiva la documentación automática del módulo
  @moduledoc false

  @impl true
  def start(_type, _args) do
    # Lista de procesos hijos que se iniciarán junto con la aplicación
    children = [
      # Repositorio Ecto (conexión a la base de datos)
      HolaApi.Repo,

      # Sistema de mensajería interna de Phoenix (PubSub)
      # Permite comunicación entre procesos (eventos, sockets, etc.)
      {Phoenix.PubSub, name: HolaApi.PubSub},

      # Endpoint web: maneja HTTP, sockets y plugs
      HolaApiWeb.Endpoint
    ]

    # Opciones del supervisor
    opts = [
      # Estrategia de supervisión:
      # si un proceso hijo falla, solo ese se reinicia
      strategy: :one_for_one,

      # Nombre del supervisor principal
      name: HolaApi.Supervisor
    ]

    # Inicia el supervisor con los procesos definidos
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    # Se ejecuta cuando la configuración cambia en caliente
    # (por ejemplo, en actualizaciones sin reiniciar el servidor)
    HolaApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
