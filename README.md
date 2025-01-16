# Laravel Docker Setup

## Описание

Этот проект представляет собой Laravel-приложение, развернутое с использованием Docker. Приложение работает в контейнерах с поддержкой PHP, PostgreSQL и Redis.

---

## Требования

Перед началом убедитесь, что у вас установлены:
- Docker (версия 20.10 или выше)
- Docker Compose (версия 1.29 или выше)

---

## Установка и запуск

### 1. Клонируйте репозиторий:
```
git clone https://github.com/legvsy/laravel-docker-setupvs.git
cd laravel-docker-setupvs
```

### 2. Создайте файл `.env`:
Скопируйте пример `.env.example` в `.env`:
```
cp .env.example .env
```

Укажите реальные значения для переменных в `.env` (например, `DB_PASSWORD`).

---

### 3. Соберите и запустите контейнеры:
```
docker-compose up -d --build
```

### 4. Установите зависимости Laravel:
```
docker exec -it laravel-app composer install
```

### 5. Выполните миграции базы данных:
```
docker exec -it laravel-app php artisan migrate
```

### 6. Доступ к приложению:
Приложение будет доступно по адресу:
```
http://localhost:8080
```

---

## Полезные команды

### Управление контейнерами:
- Проверить состояние контейнеров:
  ```
  docker ps
  ```
- Остановить контейнеры:
  ```
  docker-compose down
  ```
- Перезапустить контейнеры:
  ```
  docker-compose restart
  ```

### Работа с Laravel:
- Очистить кэш конфигурации:
  ```
  docker exec -it laravel-app php artisan config:clear
  ```
- Проверить подключение Redis:
  ```
  docker exec -it laravel-app php artisan tinker
  Cache::store('redis')->put('test_key', 'Hello, Redis!', 10);
  Cache::store('redis')->get('test_key');
  ```

### Работа с PostgreSQL:
- Подключиться к базе данных:
  ```
  docker exec -it postgres-db psql -U laravel -d laravel
  ```

---

## Пример файла `.env`

```
# Пример конфигурационного файла .env для Laravel

APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

LOG_CHANNEL=stack
LOG_LEVEL=debug

DB_CONNECTION=pgsql
DB_HOST=db
DB_PORT=5432
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=your_password_here

BROADCAST_DRIVER=log
CACHE_DRIVER=file
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

REDIS_HOST=redis
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

MIX_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
MIX_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"
```

---

## Лицензия

Этот проект распространяется под [MIT License](https://opensource.org/licenses/MIT)