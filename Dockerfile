# Usa a imagem oficial do PHP 8.2 CLI
FROM php:8.2-cli

# Define o diretório de trabalho no container
WORKDIR /app

# Copia os arquivos do projeto para o container
COPY . /app

# Instala dependências do sistema e extensões PHP necessárias
RUN apt-get update && apt-get install -y unzip libzip-dev libpq-dev libonig-dev git && \
    docker-php-ext-install zip pdo pdo_mysql sockets

# Instala o Composer globalmente
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Garante que o Composer usa a versão mais recente
RUN composer self-update

# Força a instalação das dependências
RUN composer install --no-interaction --no-dev --optimize-autoloader

# Expõe a porta usada pelo WebSocket
EXPOSE 8080

# Comando para iniciar o servidor WebSocket
CMD ["php", "server.php"]
