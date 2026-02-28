# Этап 1: сборка приложения
FROM node:18-alpine AS build

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы зависимостей
COPY package.json package-lock.json ./

# Устанавливаем зависимости
RUN npm ci

# Копируем исходный код
COPY . .

# Собираем приложение для продакшена
RUN npm run build

# Этап 2: сервер для статики
FROM nginx:stable-alpine

# Копируем собранные файлы из первого этапа
COPY --from=build /app/build /usr/share/nginx/html

# Копируем кастомный конфиг nginx (опционально)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Открываем порт 80
EXPOSE 80

# Запускаем nginx
CMD ["nginx", "-g", "daemon off;"]