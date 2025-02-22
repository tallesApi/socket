# Usa a imagem oficial do PHP com suporte a extensões
FROM php:8.0-cli

# Define o diretório de trabalho no container
WORKDIR /app

# Copia os arquivos do projeto para o container
COPY . /app

# Instala as dependências do sistema operacional necessárias
RUN apt-get update && apt-get install -y unzip

# Instala o Composer globalmente
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Verifica se o composer.json existe antes de rodar o install
RUN if [ -f "composer.json" ]; then composer install --no-interaction --no-dev --optimize-autoloader; fi

# Expõe a porta usada pelo WebSocket
EXPOSE 8080

# Comando para iniciar o servidor WebSocket
CMD ["php", "server.php"]
