defmodule HolaApiWeb.Endpoint do
  # Define el Endpoint principal de Phoenix
  # Es el punto de entrada para todas las peticiones HTTP
  use Phoenix.Endpoint, otp_app: :hola_api

  # Asigna un identificador único a cada petición
  # Útil para depuración y trazabilidad en logs
  plug Plug.RequestId

  # Envía métricas y eventos de la petición
  # Se usa para monitoreo y telemetría de la aplicación
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  # Configura cómo se procesan los datos que llegan en las peticiones
  # Soporta formularios, archivos y JSON
  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason

  # Permite sobrescribir el método HTTP (GET, POST, PUT, DELETE)
  # Útil cuando el cliente no soporta ciertos métodos
  plug Plug.MethodOverride

  # Maneja correctamente las peticiones HEAD
  plug Plug.Head

      plug CORSPlug, origin: "*"

  # Configura el manejo de sesiones usando cookies
  # key: nombre de la cookie
  # signing_salt: firma para evitar manipulación de la sesión
  plug Plug.Session,
    store: :cookie,
    key: "_hola_api_key",
    signing_salt: "123456"

  # Redirige la petición al Router
  # El Router decide qué controlador y acción se ejecutan
  plug HolaApiWeb.Router


end
