#============================================================================================
# FROM [nome da imagem]:[versão/tag da imagem]
# Referência: https://docs.docker.com/engine/reference/builder/#from
#
# Define uma imagem local ou pública do Docker Store. Em sua primeira execução, ela será
# baixada para o computador e usada no build para criar as imagens a serem utilizadas.
#============================================================================================
ARG BASE_IMAGE=php:7.3.7-fpm-alpine3.10
FROM ${BASE_IMAGE}

#============================================================================================
# LABEL maintainer=[nome e e-mail do mantenedor da imagem]
# Referência: https://docs.docker.com/engine/reference/builder/#label
#
# Indica o responsável/autor por manter a imagem.
#============================================================================================
LABEL maintainer="Kaio César Bezerra Rangel <kaio.ufcg@gmail.com>"

# Instalação do bash shell no Alpine Linux e do MySQL Client
RUN apk add bash mysql-client
# Extensões do PHP
RUN docker-php-ext-install pdo pdo_mysql

#============================================================================================
# WORKDIR [caminho do diretório de trabalho]
# Referência: https://docs.docker.com/engine/reference/builder/#workdir
#
# Define qual será o diretório de trabalho (o caminho da aplicação dentro do container
# onde serão copiados os arquivos, e criadas novas pastas)
#============================================================================================
WORKDIR /var/www

#============================================================================================
# RUN <comando como no shell linux ou windows>
# ou
# RUN ["executável", "parâmetro1", "parâmetro2"]
# Referência: https://docs.docker.com/engine/reference/builder/#run
#
# Especifica que o argumento seguinte será executado, ou seja, realiza a execução de um comando.
#============================================================================================
# Remove a pasta padrão do html do PHP
RUN rm -rf /var/www/html/
# Gerenciador de pacotes do PHP
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Laravel
#RUN composer install && \
#                cp .env.example .env && \
#                php artisan key::generate && \
#                php artisan config:cache
# Criação de link simbolico: $ ln -s {/path/to/file-name} {link-name}
RUN ln -s public html

#============================================================================================
# COPY [arquivo a ser copiado] [destino do arquivo copiado]
# Referência: https://docs.docker.com/engine/reference/builder/#copy
#
# Copia os arquivos da aplicação, para dentro do caminho especificado dentro do container.
# COPY test relativeDir/   # adds "test" to `WORKDIR`/relativeDir/
# COPY test /absoluteDir/  # adds "test" to /absoluteDir/
#============================================================================================
#COPY . /var/www

#============================================================================================
# EXPOSE [número da porta]
# Referência: https://docs.docker.com/engine/reference/builder/#expose
#
# Irá expor a porta para a máquina host (hospedeira). É possível expor múltiplas portas, como
# por exemplo: EXPOSE 80 443 8080
#============================================================================================
EXPOSE 9000

#============================================================================================
# ENTRYPOINT [executável seguido dos parâmetros]
# Referência: https://docs.docker.com/engine/reference/builder/#entrypoint
#
# Inicia o container como um executável a partir da inicialização da aplicação. Essa instrução
# é muito útil quando o container está em modo Swarm (Cluster de containers), pois caso a
# aplicação caia, o container cai junto, indicando ao cluster aplicar a política de restart
# configurada para a aplicação.
#
# Obs.: Diferentemente do CMD, o ENTRYPOINT não é sobrescrito, isso quer dizer que este
# comando será sempre executado.
#============================================================================================
ENTRYPOINT ["php-fpm"]