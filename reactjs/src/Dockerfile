# 1. Empaquetar tu aplicación
# Usamos Node 18 (o cambia por la versión de tu proyecto)
FROM node:18-alpine as build

# Creamos y establecemos el directorio de trabajo
WORKDIR /app

# Copiamos package.json y package-lock.json
COPY package*.json ./

# Instalamos las dependencias
RUN npm install

# Copiamos el resto de tu código
COPY . .

# Construimos la aplicación de React para producción
RUN npm run build

# 2. Servir la aplicación
# Usamos un servidor ligero como Nginx
FROM nginx:alpine

# Copiamos el resultado del paso anterior ("build") a la carpeta de nginx
COPY --from=build /app/build /usr/share/nginx/html

# Exponemos el puerto 80
EXPOSE 80

# Comando para iniciar el servidor
CMD ["nginx", "-g", "daemon off;"]
