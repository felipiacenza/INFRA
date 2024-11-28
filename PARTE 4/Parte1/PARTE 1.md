# Investigación

## IPD

### ¿Qué es una IDP?

Es una plataforma interna diseñada para ayudar a los desarrolladores a construir, desplegar y gestionar aplicaciones de manera más eficiente. Proporciona herramientas y servicios que simplifican el trabajo de los desarrolladores. 
Actúan como un puente entre los desarrolladores, infraestructura y herramientas, facilitando el desarrollo del software. UUn IDP no es solo un conjunto de herramientas, sino una plataforma integral diseñada para optimizar los flujos de trabajo, mejorar la colaboración y acelerar la entrega de software.

Sin embargo, este término no debe confundirse con otro que tiene la misma sigla, que es la Identity Provider (sistema que proporciona servicios de autenticación y autorización para aplicaciones.)

### Usos:
- Automatización de procesos: Simplificar tareas repetitivas como la creación de entornos de desarrollo, pruebas y producción.
- Facilitación del acceso a servicios: Proveer una interfaz común para acceder a bases de datos, APIs, y otros servicios.
- Integración continua y entrega continua (CI/CD): Facilitar la implementación de prácticas de DevOps.
- Colaboración: Permitir que los equipos trabajen de forma más conjunta y efectiva, compartiendo recursos y conocimientos.

## Imagen en Docker

### Requerimientos:

Visual Studio Code Server.
Node.js y npm, si se van a utilizar extensiones que lo requieran.
Otras dependencias como git.

### Imagen base:

Se puede utilizar una imagen oficial de Node.js, ya que Visual Studio Code Server es un servicio que se ejecuta sobre Node.js.
Ejemplo: FROM node:14.

### Puertos a exponer:

Exponer el puerto 8080, que es el puerto predeterminado para acceder a Visual Studio Code Server.
Si se requiere acceso a la interfaz de usuario, es posible que se necesite exponer el puerto 3000.

### Archivo de configuración:

Se debe crear un archivo de configuración que especifique los ajustes de VS Code Server (como extensiones, configuración del usuario, etc.), que se copiará al contenedor durante el proceso de construcción.

```
# Dockerfile
FROM node:14

# Establecer el directorio de trabajo
WORKDIR /usr/src/app

# Copiar el archivo de configuración
COPY config.json ./config.json

# Instalar dependencias si es necesario
RUN npm install -g code-server

# Exponer el puerto para el servidor
EXPOSE 8080

# Comando para iniciar el servidor
CMD ["code-server", "--host", "0.0.0.0", "--port", "8080", "--auth", "none"]
```

### Docker compose

```
version: '3.8'

services:
  vscode-server:
    build: .
    ports:
      - "8080:8080"
    volumes:
      - ./workspace:/home/coder/project
    environment:
      - PASSWORD=password

```