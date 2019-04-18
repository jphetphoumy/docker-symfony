FROM alpine:3.9
LABEL maintainer="j.phetphoumy@gmail.com"

RUN apk add --no-cache php7 \
                       php7-openssl \
                       php7-json \
                       php7-phar \
                       php7-iconv \
                       php7-xmlwriter \
                       php7-dom \
                       php7-tokenizer \
                       php7-mbstring \
                       php7-xml \
                       php7-pdo \
                       php7-ctype

# Download and install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

# Check validity of the file
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

# Run composer setup 
RUN php composer-setup.php --install-dir=bin --filename=composer
ADD . /application
WORKDIR /application
RUN cp app/config/parameters.yml.dist  app/config/parameters.yml && \
    composer install 
