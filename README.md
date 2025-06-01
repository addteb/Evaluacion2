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

+ Redacta un archivo Dockerfile que construya una imagen Docker con Nagios Core.  [x]
+ La imagen debe incluir todas las dependencias necesarias para que Nagios funcione correctamente. [x]
+ Configura Nagios para que inicie automáticamente al arrancar el contenedor. [x]
+ Considera exponer el puerto 80 para acceder a la interfaz web de Nagios. [x]
+ Construye la imagen y verifica que Nagios sea accesible localmente. [x]
+ Sube el código del Dockerfile y otros archivos que requieras para construir la imagen a un repositorio GitHub. [x]
+ Crea un archivo README.md en el repositorio que explique detalladamente los pasos para construir la imagen y ejecutar el contenedor. [x]


---
# Desarrollo


## Creación de la Imagen Docker: 

### Se utilizo una imagen bae Ubuntu 22.04

```bash
FROM ubuntu:22.04
```

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
```

 ### Se agregan los usuarios y permisos

```bash
seradd nagios && \
    groupadd nagcmd && \
    usermod -a -G nagcmd nagios && \
    usermod -a -G nagcmd www-data
```

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
```

### Exponer puerto del contenedor
```bash
EXPOSE 80
```

---
# Creación de imagen
para Crear imagen estando en el directorio utilice el siguiente comando para crear la imagen
```bash
 docker build -t duoc/epizarro . docker build -t duoc/epizarro .
```
## Envio a AWS ECR

Antes de enviar la imagen a AWS realice el siguiente tag
```bash
docker tag duoc/epizarro:latest 433474845020.dkr.ecr.us-east-1.amazonaws.com/duoc/epizarro:latest
```
### Hago el envío a AWS ECR
```bash
docker push 433474845020.dkr.ecr.us-east-1.amazonaws.com/duoc/epizarro:latest
```



## Construir la imagen local
Para construir la Imagen de manera local seguir lo siguiente

###  Clonar el repositorio


```bash
git clone https://github.com/addteb/Evaluacion2.git
cd tu-repositorio 
```

### Construir Imagen
Estando en la ubicacion del archivo Dockerfile a ejecutar
```bash

docker build -t nagios .
```

### Ejecutar Contenedor
```bash
docker run -d --name nagios-container -p 80:80 nagios
```

### Conectarse al Docker

Según se la configuracion se debe acceder al servicio

http://iphostOdelcontenedor/nagios


### Usuario de conexion

```bash
user: nagiosadmin
password: nagios
```
---

## Despliegue en AWS ECS: 

+ Sube la imagen Docker creada a un repositorio de Elastic Container Registry (ECR).  [x]
+ Crea un sistema de archivos EFS y configúralo para que sea accesible desde ECS. [x]
+ Define una tarea en ECS que utilice la imagen de Nagios del ECR. [x]
+ Configura el montaje del EFS en el directorio principal de Nagios en cada contenedor. [-]
+ Crea un servicio ECS con 3 tareas deseadas. [x]
+ Configura un Application Load Balancer (ALB) para distribuir el tráfico entre las tareas. [x]
+ Verifica que Nagios sea accesible a través de la URL del ALB. [x]
+ Confirma que los datos de Nagios se almacenan persistentemente en el EFS. [-]


Para el Despliege en AWS se realizo lo siguiente en el orden que indico

+ Creación de repositorio en ECR
+ Creación de SG 
+ Creación de Volumen EFS
+ Creación de permisos
+ Creación de Cluster ECS
+ Creación de tareas en ECS
+ Creación de Servicios en ECR
+ Se realiza Despliegue de contenedores
+ Creación de Balanceador de Carga
+ Configuración de SG para Balanceador de Carga y NFS
+ Pruebas finales.




