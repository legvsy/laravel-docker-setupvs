FROM php:8.3-fpm-alpine

# Установка зависимостей и инструментов сборки
RUN apk add --no-cache \
    bash \
    git \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    postgresql-dev \
    icu-dev \
    oniguruma-dev \
    libxpm-dev \
    libxml2-dev \
    autoconf \
    g++ \
    make \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-xpm \
    && docker-php-ext-install -j$(nproc) \
        gd \
        pdo \
        pdo_pgsql \
        zip \
        bcmath \
        intl \
        xml \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del --no-cache \
        autoconf \
        g++ \
        make

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Настройка рабочего каталога
WORKDIR /var/www/html

# Копирование исходного кода
COPY ./app /var/www/html

# Установка прав
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage /var/www/html/bootstrap/cache

# Установка зависимостей Laravel
RUN composer install --no-dev --optimize-autoloader

# Команда для запуска
CMD php artisan migrate && php artisan serve --host=0.0.0.0 --port=8000