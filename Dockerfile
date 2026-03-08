# ETAPA: 1 CONSTRUIR IMAGEN
FROM node:18-alpine as build 

WORKDIR /app
# Definimos los argumentos que esperamos recibir
ARG REACT_APP_API_URL
ARG REACT_APP_ENVIRONMENT

# Los convertimos en variables de entorno para el proceso de build
ENV REACT_APP_API_URL=$REACT_APP_API_URL
ENV REACT_APP_ENVIRONMENT=$REACT_APP_ENVIRONMENT

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

# ETAPA: 2 SERVIR LA IMAGEN

FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
