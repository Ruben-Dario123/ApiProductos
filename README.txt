#  API de Gestion de Productos

Una API RESTful segura y documentada, diseñada específicamente para la gestión interna de servicios y productos. Este sistema permite a los trabajadores registrarse, autenticarse de manera segura y administrar su catálogo de productos.

---

## Tecnologías Utilizadas y el "Por Qué"

Este proyecto fue construido utilizando herramientas modernas y estándares de la industria para asegurar rendimiento, escalabilidad y facilidad de despliegue:

* **Elixir & Phoenix Framework:** * *¿Por qué?* Elixir, ejecutándose sobre la máquina virtual de Erlang, ofrece una concurrencia y tolerancia a fallos excepcional. Phoenix nos permite construir una API extremadamente rápida y confiable, ideal para manejar datos clínicos sin cuellos de botella.
* **SQLite:** * *¿Por qué?* Es un motor de base de datos SQL transaccional ligero y autónomo. Se eligió para mantener la portabilidad del proyecto, ya que no requiere configurar un servidor de base de datos independiente, facilitando su evaluación y despliegue rápido.
* **Guardian (JSON Web Tokens - JWT):** * *¿Por qué?* La seguridad es primordial en entornos clínicos. Guardian nos permite generar tokens de acceso con un tiempo de vida limitado (30 minutos). Esto asegura que las rutas críticas estén protegidas y que las sesiones inactivas expiren automáticamente.
* **Docker & Docker Compose:** * *¿Por qué?* Para garantizar que la aplicación funcione exactamente igual en cualquier entorno (desarrollo, pruebas o producción). Conteneriza la aplicación junto con sus dependencias, eliminando el problema de "en mi máquina sí funciona".
* **Swagger (OpenAPI):** * *¿Por qué?* Proporciona una interfaz gráfica interactiva y amigable. Permite a cualquier usuario o evaluador probar todas las rutas de la API, enviar datos y recibir respuestas directamente desde el navegador, sin necesidad de instalar herramientas externas como Postman.

---

##  Requisitos Previos

Para ejecutar este proyecto en tu entorno local, solo necesitas tener instalado:
* [Docker Desktop](https://www.docker.com/products/docker-desktop/)

---

## Instalación y Ejecución Local

Sigue estos pasos para levantar el servidor en tu computadora:

1.  **Clona este repositorio:**
    ```bash
    git clone https://github.com/Ruben-Dario123/ApiProductos.git
    cd ApiProductos
    ```

2.  **Levanta los contenedores con Docker:**
    Este comando descargará las imágenes necesarias, compilará el código de Elixir y encenderá el servidor de la API y la interfaz de Swagger.
    ```bash
    docker compose up --build
    ```

3.  **Accede a la aplicación:**
    * Interfaz interactiva (Swagger): `http://localhost:8080`
    * URL base de la API: `http://localhost:4000`

---

## Guía de Uso (Flujo de Trabajo)

La API está protegida, por lo que debes seguir este flujo desde la interfaz de Swagger (`http://localhost:8080`) para poder interactuar con los datos:

### 1. Registro de Usuario
Dirígete al método **`POST /auth/register`**. Haz clic en *Try it out* y envía un JSON con tu nombre de usuario y contraseña para crear la cuenta del trabajador en la base de datos.

### 2. Iniciar Sesión (Obtener Token)
Dirígete al método **`POST /auth/login`**. Envía las mismas credenciales que registraste en el paso anterior. El servidor responderá con un código `200 OK` y te entregará un **Token JWT** (una cadena larga de texto). Copia ese token.

### 3. Autorización (Abrir el Candado)
En la parte superior derecha de Swagger, haz clic en el botón verde **Authorize**. Pega el token que copiaste y haz clic en *Authorize*. Ahora estás autenticado.

### 4. Gestión de Productos (CRUD)
Con el candado cerrado, ahora tienes acceso a las rutas protegidas:
* **`POST /producto`**: Crea nuevos servicios (ej. "Terapia individual", "Evaluación psicométrica").
* **`PUT /producto/{id}`**: Modifica el nombre o precio de un servicio existente.
* **`DELETE /producto/{id}`**: Elimina un servicio del catálogo.
* *Nota: Las rutas `GET` para consultar la lista de productos son de acceso público.*

