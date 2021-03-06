FROM php:5.6

RUN apt-get update
RUN apt-get -y install git
RUN cd /tmp; php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"; php composer-setup.php --install-dir=/usr/local/bin --filename=composer; php -r "unlink('composer-setup.php');"
RUN apt-get -y install curl
RUN curl -sS https://platform.sh/cli/installer | php
ADD config.yaml /root/.platformsh/config.yaml
ADD apitoken /root/.platformsh/apitoken
RUN mkdir -p /root/.ssh
ADD id_rsa /root/.ssh/id_rsa
ADD id_rsa.pub /root/.ssh/id_rsa.pub
RUN chmod 400 /root/.ssh/id_rsa
ADD ssh-config /root/.ssh/config
