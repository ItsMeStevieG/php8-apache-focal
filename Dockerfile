FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y ca-certificates apt-transport-https software-properties-common && \
    add-apt-repository ppa:ondrej/php -y && \
    apt-get update -y
RUN apt-get install -y \
    apache2 \
    php8.0 \
    libapache2-mod-php8.0 \
    php8.0-fpm \
    libapache2-mod-fcgid \
    php8.0-common \
    php8.0-mysql \
    php8.0-xml \
    php8.0-curl \
    php8.0-gd \
    php8.0-imagick \
    php8.0-cli \
    php8.0-dev \
    php8.0-imap \
    php8.0-mbstring \
    php8.0-opcache \
    php8.0-soap \
    php8.0-zip && \
    service apache2 restart
RUN sed -E -i -e '/<Directory "\/var\/www\/html">/,/<\/Directory>/s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf\
    && sed -E -i -e 's/DirectoryIndex (.*)$/DirectoryIndex index.php \1/g' /etc/apache2/apache2.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN sed -E -i -e 's/max_execution_time = .*$/max_execution_time = 120/' /etc/php/8.0/cli/php.ini\
    && sed -E -i -e 's/memory_limit = .*$/memory_limit = 512M/' /etc/php/8.0/cli/php.ini\
    && sed -E -i -e 's/post_max_size = .*$/post_max_size = 64M/' /etc/php/8.0/cli/php.ini\
    && sed -E -i -e 's/upload_max_filesize = .*$/upload_max_filesize = 64M/' /etc/php/8.0/cli/php.ini
RUN sed -E -i -e 's/max_execution_time = .*$/max_execution_time = 120/' /etc/php/8.0/apache2/php.ini\
    && sed -E -i -e 's/memory_limit = .*$/memory_limit = 512M/' /etc/php/8.0/apache2/php.ini\
    && sed -E -i -e 's/post_max_size = .*$/post_max_size = 64M/' /etc/php/8.0/apache2/php.ini\
    && sed -E -i -e 's/upload_max_filesize = .*$/upload_max_filesize = 64M/' /etc/php/8.0/apache2/php.ini
RUN sed -E -i -e 's/max_execution_time = .*$/max_execution_time = 120/' /etc/php/8.0/fpm/php.ini\
    && sed -E -i -e 's/memory_limit = .*$/memory_limit = 512M/' /etc/php/8.0/fpm/php.ini\
    && sed -E -i -e 's/post_max_size = .*$/post_max_size = 64M/' /etc/php/8.0/fpm/php.ini\
    && sed -E -i -e 's/upload_max_filesize = .*$/upload_max_filesize = 64M/' /etc/php/8.0/fpm/php.ini
EXPOSE 80 
CMD ["apache2ctl", "-D", "FOREGROUND"]