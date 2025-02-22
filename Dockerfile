# Use uma imagem base do PHP (CLI)
FROM php:8.4-cli

# Define o diretório de trabalho no container
WORKDIR /app

# Copia os arquivos do projeto para o container
COPY . /app

# Instala o Composer globalmente
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instala as dependências do Composer
RUN composer install

# Expõe a porta (a Railway usará a variável PORT, mas é bom declarar uma porta padrão)
EXPOSE 8080

# Comando para iniciar o servidor WebSocket
CMD ["php", "server.php"]
