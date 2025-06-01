# Evaluación Parcial EA2

Este proyecto tiene como objetivo medir la capacidad para:

+ Crear imágenes Docker
+ Desplegar aplicaciones en AWS ECS
+ Configurar servicios de monitoreo con Nagios

A través de esta actividad práctica, demostrarás tus habilidades en:

+ Gestión de contenedores
+ Administración de infraestructura en la nube
+ Implementación de herramientas de monitoreo esenciales

---
# Instrucciones
## Creación de la Imagen Docker: 

+ Redacta un archivo Dockerfile que construya una imagen Docker con Nagios Core. 
+ La imagen debe incluir todas las dependencias necesarias para que Nagios funcione correctamente. 
+ Configura Nagios para que inicie automáticamente al arrancar el contenedor. 
+ Considera exponer el puerto 80 para acceder a la interfaz web de Nagios. 
+ Construye la imagen y verifica que Nagios sea accesible localmente. 
+ Sube el código del Dockerfile y otros archivos que requieras para construir la imagen a un repositorio GitHub. 
+ Crea un archivo README.md en el repositorio que explique detalladamente los pasos para construir la imagen y ejecutar el contenedor. 

## Despliegue en AWS ECS: 

+ Sube la imagen Docker creada a un repositorio de Elastic Container Registry (ECR). 
+ Crea un sistema de archivos EFS y configúralo para que sea accesible desde ECS. 
+ Define una tarea en ECS que utilice la imagen de Nagios del ECR. 
+ Configura el montaje del EFS en el directorio principal de Nagios en cada contenedor. 
+ Crea un servicio ECS con 3 tareas deseadas. 
+ Configura un Application Load Balancer (ALB) para distribuir el tráfico entre las tareas. 
+ Verifica que Nagios sea accesible a través de la URL del ALB. 
+ Confirma que los datos de Nagios se almacenan persistentemente en el EFS. 

---
# Desarrollo


## Creación de la Imagen Docker: 

### Se utilizo una imagen bae Ubuntu 22.04

```bash
FROM ubuntu:22.04
```bash

### Dependencias utilizadas

```bash
apt-get update && \
    apt-get install --no-install-recommends -y \
    ca-certificates \
    autoconf \
    gcc \
    make \
    unzip \
    wget \
    apache2 \
    php \
    libapache2-mod-php \
    libgd-dev \
    libssl-dev \
    daemon \
    libperl-dev \
    libnet-snmp-perl \
    libmysqlclient-dev \
    curl && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/*
```bash

 ### Se agregan los usuarios y permisos

```bash
seradd nagios && \
    groupadd nagcmd && \
    usermod -a -G nagcmd nagios && \
    usermod -a -G nagcmd www-data
```bash

### descarga y compila Nagios
 
```bash

wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.5.9.tar.gz && \
    tar -xzf nagios-4.5.9.tar.gz && \
    cd nagios-4.5.9 && \
    ./configure --with-command-group=nagcmd && \
    make all && \
    make install && \
    make install-commandmode && \
    make install-init && \
    make install-config && \
    make install-webconf && \
    htpasswd -cb /usr/local/nagios/etc/htpasswd.users nagiosadmin nagios && \
    cd .. && rm -rf nagios-4.5.9*
```bash
---
## Para Ejecutar el Dockerfile
##  Clonar el repositorio


```bash
git clone https://github.com/tu-usuario/tu-repositorio.git
cd tu-repositorio
```bash
## Construir Imagen
```bash

docker build -t nagios .
```bash
## Ejecutar Contenedor
```bash
docker run -d --name nagios-container -p 80:80 nagios
```bash

## Exponer puerto 
```bash
EXPOSE 80
```bash

# Usuario de conexion

```bash
user: nagiosadmin
password: nagios
```bash


