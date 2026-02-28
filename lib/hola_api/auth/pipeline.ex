defmodule HolaApi.Guardian.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :hola_api,
    error_handler: HolaApi.Guardian.ErrorHandler,
    module: HolaApi.Guardian

  # Estos son los pasos que revisan el token:
  plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
