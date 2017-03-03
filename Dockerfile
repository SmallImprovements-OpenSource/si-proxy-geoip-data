FROM node:7.7.1-alpine
WORKDIR /tmp

ADD . .
RUN npm install

ADD http://geolite.maxmind.com/download/geoip/database/GeoLite2-City-CSV.zip .
ADD http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country-CSV.zip .

RUN unzip GeoLite2-City-CSV.zip && rm GeoLite2-City-CSV.zip
RUN unzip GeoLite2-Country-CSV.zip && rm GeoLite2-Country-CSV.zip

RUN mkdir /geoip-data

RUN node index\
    GeoLite2-Country-*/GeoLite2-Country-Blocks-IPv4.csv\
    GeoLite2-Country-*/GeoLite2-Country-Locations-en.csv\
    country_iso_code > /geoip-data/countries.map

RUN node index\
    GeoLite2-City-*/GeoLite2-City-Blocks-IPv4.csv\
    GeoLite2-City-*/GeoLite2-City-Locations-en.csv\
    city_name > /geoip-data/cities.map

RUN rm -r ./*

VOLUME ["/geoip-data"]
