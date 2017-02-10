FROM php:5.6-fpm

ENV NR_VERSION 6.9.0.182
ENV NR_INSTALL_SILENT true

RUN mkdir -p /opt/newrelic && \
      cd /opt/newrelic && \
      curl -LO https://download.newrelic.com/php_agent/release/newrelic-php5-${NR_VERSION}-linux.tar.gz && \
      tar -xzf newrelic-php*.tar.gz --strip=1 && rm newrelic-php*.tar.gz && \
      /opt/newrelic/newrelic-install install
      
COPY newrelic.agent.conf /usr/local/etc/php/conf.d/newrelic.ini
