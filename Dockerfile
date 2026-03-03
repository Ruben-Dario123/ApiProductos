# Usamos la imagen oficial de Elixir
FROM elixir:latest

# Instalamos algunas herramientas necesarias en Linux para que SQLite funcione bien
RUN apt-get update && apt-get install -y build-essential inotify-tools

# Creamos una carpeta dentro del contenedor llamada /app
WORKDIR /app

# Instalamos las herramientas básicas que Elixir usa para manejar paquetes
RUN mix local.hex --force && \
    mix local.rebar --force

# Copiamos TODOS tus archivos (los de la foto que me enviaste) a la cajita
COPY . .

# Descargamos las dependencias de tu proyecto Elixir
RUN mix deps.get

# Exponemos el puerto 4000 que es el que usa Phoenix por defecto
EXPOSE 4000

# El comando final que arranca tu API
CMD ["sh", "-c", "mix ecto.migrate && mix phx.server"]
