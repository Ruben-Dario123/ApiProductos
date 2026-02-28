defmodule HolaApi.Guardian do
  use Guardian, otp_app: :hola_api

  # Este método identifica al usuario dentro del token (usaremos el username)
  def subject_for_token(usuario, _claims) do
    {:ok, to_string(usuario.username)}
  end

  # Este método recupera al usuario cuando el token regresa
  def resource_from_claims(%{"sub" => username}) do
    # Aquí podrías buscar en la base de datos, por ahora devolvemos el nombre
    {:ok, %{username: username}}
  end
end
