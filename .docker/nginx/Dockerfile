#============================================================================================
# FROM [nome da imagem]:[versão/tag da imagem]
# Referência: https://docs.docker.com/engine/reference/builder/#from
#
# Define uma imagem local ou pública do Docker Store. Em sua primeira execução, ela será
# baixada para o computador e usada no build para criar as imagens a serem utilizadas.
#============================================================================================
ARG BASE_IMAGE=nginx:1.17.1-alpine
FROM ${BASE_IMAGE}

#============================================================================================
# LABEL maintainer=[nome e e-mail do mantenedor da imagem]
# Referência: https://docs.docker.com/engine/reference/builder/#label
#
# Indica o responsável/autor por manter a imagem.
#============================================================================================
LABEL maintainer="Kaio César Bezerra Rangel <kaio.ufcg@gmail.com>"

#============================================================================================
# RUN <comando como no shell linux ou windows>
# ou
# RUN ["executável", "parâmetro1", "parâmetro2"]
# Referência: https://docs.docker.com/engine/reference/builder/#run
#
# Especifica que o argumento seguinte será executado, ou seja, realiza a execução de um comando.
#============================================================================================
# Removendo o arquivo de configurações do NGINX
RUN rm /etc/nginx/conf.d/default.conf

#============================================================================================
# COPY [arquivo a ser copiado] [destino do arquivo copiado]
# Referência: https://docs.docker.com/engine/reference/builder/#copy
#
# Copia os arquivos da aplicação, para dentro do caminho especificado dentro do container.
#============================================================================================
COPY ./nginx.conf /etc/nginx/conf.d
