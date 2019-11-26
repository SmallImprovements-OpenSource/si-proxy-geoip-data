FROM node:11.9.0-alpine

WORKDIR /tmp

ENV VERSION 20191119

ADD . .

RUN npm install

RUN wget -q https://geolite.maxmind.com/download/geoip/database/GeoLite2-City-CSV_${VERSION}.zip \
            https://geolite.maxmind.com/download/geoip/database/GeoLite2-Country-CSV_${VERSION}.zip && \
    unzip -q GeoLite2-City-CSV_${VERSION} && \
    unzip -q GeoLite2-Country-CSV_${VERSION} && \
    mkdir /geoip-data && \
    node index \
        GeoLite2-City-CSV_${VERSION}/GeoLite2-City-Blocks-IPv4.csv \
        GeoLite2-City-CSV_${VERSION}/GeoLite2-City-Locations-en.csv \
        city_name > /geoip-data/cities.map && \
    node index \
        GeoLite2-Country-CSV_${VERSION}/GeoLite2-Country-Blocks-IPv4.csv \
        GeoLite2-Country-CSV_${VERSION}/GeoLite2-Country-Locations-en.csv \
        country_iso_code > /geoip-data/countries.map && \
    node index \
        GeoLite2-Country-CSV_${VERSION}/GeoLite2-Country-Blocks-IPv4.csv \
        GeoLite2-Country-CSV_${VERSION}/GeoLite2-Country-Locations-en.csv \
        continent_code > /geoip-data/continents.map && \
    node index \
        GeoLite2-City-CSV_${VERSION}/GeoLite2-City-Blocks-IPv4.csv \
        GeoLite2-City-CSV_${VERSION}/GeoLite2-City-Locations-en.csv \
        time_zone > /geoip-data/timezones.map && \
    \
    rm -r ./*

VOLUME ["/geoip-data"]
