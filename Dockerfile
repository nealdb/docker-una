FROM ubuntu:bionic
ENV TZ=Europe/London
ENV VER=12.0.0
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
  && apt-get update \
  && apt-get install -y php \
       php-curl \
       php-gd \
       php-mbstring \
       php-xml \
       php-zip \
       wget \
       unzip \
  && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
  && rm /var/www/html/index.html \
  && wget -O UNA.zip https://github.com/unaio/una/archive/12.0.0.zip \
  && ln -s /var/www/html una-$VER \
  && unzip UNA.zip \
  && rm UNA.zip \
  && rm /tmp/una-$VER

RUN chown -R www-data:www-data /var/www/html/ \
  && chmod +x /var/www/html/plugins/ffmpeg/ffmpeg.exe

EXPOSE 80
CMD apachectl -D FOREGROUND
