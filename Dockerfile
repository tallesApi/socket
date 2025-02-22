# Usa a imagem oficial do PHP 8.2 CLI
FROM php:8.2-cli

# Define o diretório de trabalho no container
WORKDIR /app

# Copia os arquivos do projeto para o container
COPY . /app

# Instala dependências do sistema operacional necessárias para o Composer e PHP
RUN apt-get update && apt-get install -y unzip libzip-dev libpq-dev libonig-dev && \
    docker-php-ext-install zip pdo pdo_mysql

# Instala o Composer globalmente
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Verifica se composer.json existe antes de rodar o install
RUN composer install --no-interaction --no-dev --optimize-autoloader; fi

# Expõe a porta usada pelo WebSocket
EXPOSE 8080

# Comando para iniciar o servidor WebSocket
CMD ["php", "server.php"]
