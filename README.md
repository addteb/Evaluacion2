# Evaluación Parcial EA2

Este proyecto tiene como objetivo medir la capacidad para:

- Crear imágenes Docker
- Desplegar aplicaciones en AWS ECS
- Configurar servicios de monitoreo con Nagios

A través de esta actividad práctica, demostrarás tus habilidades en:

- Gestión de contenedores
- Administración de infraestructura en la nube
- Implementación de herramientas de monitoreo esenciales

---
#Instrucciones
##Creación de la Imagen Docker: 

-Redacta un archivo Dockerfile que construya una imagen Docker con Nagios Core. 
-La imagen debe incluir todas las dependencias necesarias para que Nagios funcione correctamente. 
-Configura Nagios para que inicie automáticamente al arrancar el contenedor. 
-Considera exponer el puerto 80 para acceder a la interfaz web de Nagios. 
-Construye la imagen y verifica que Nagios sea accesible localmente. 
-Sube el código del Dockerfile y otros archivos que requieras para construir la imagen a un repositorio GitHub. 
-Crea un archivo README.md en el repositorio que explique detalladamente los pasos para construir la imagen y ejecutar el contenedor. 

##Despliegue en AWS ECS: 

-Sube la imagen Docker creada a un repositorio de Elastic Container Registry (ECR). 
-Crea un sistema de archivos EFS y configúralo para que sea accesible desde ECS. 
-Define una tarea en ECS que utilice la imagen de Nagios del ECR. 
-Configura el montaje del EFS en el directorio principal de Nagios en cada contenedor. 
-Crea un servicio ECS con 3 tareas deseadas. 
-Configura un Application Load Balancer (ALB) para distribuir el tráfico entre las tareas. 
-Verifica que Nagios sea accesible a través de la URL del ALB. 
-Confirma que los datos de Nagios se almacenan persistentemente en el EFS. 




##  Clonar el repositorio

```bash
git clone https://github.com/tu-usuario/tu-repositorio.git
cd tu-repositorio

# Construir Imagen
docker build -t nagios .

## Ejecutar Contenedor
docker run -d --name nagios-container -p 80:80 nagios

## Estructura del proyecto
.
├── Dockerfile
├── README.md
└── ...


