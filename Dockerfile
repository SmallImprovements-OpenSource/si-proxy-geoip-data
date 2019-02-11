FROM node:8.15.0-alpine
WORKDIR /tmp

ENV VERSION 20180206

ADD . .

RUN apk add --update curl && \
    rm -rf /var/cache/apk/${VERSION}

RUN curl -sSLO http://geolite.maxmind.com/download/geoip/database/GeoLite2-City-CSV_${VERSION}.zip && \
    curl -sSLO http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country-CSV_${VERSION}.zip && \
    unzip GeoLite2-City-CSV_${VERSION}.zip && unzip GeoLite2-Country-CSV_${VERSION}.zip && \
    mkdir /geoip-data && \
    npm install && \
    \
    for property in "city_name continent_code country_iso_code"; \
    do \
      node index \
          GeoLite2-City-${VERSION}/GeoLite2-City-Blocks-IPv4.csv \
          GeoLite2-City-${VERSION}/GeoLite2-City-Locations-en.csv \
          $property > /geoip-data/$property.map \
    done;\
    \
    rm -r ./${VERSION}

VOLUME ["/geoip-data"]
