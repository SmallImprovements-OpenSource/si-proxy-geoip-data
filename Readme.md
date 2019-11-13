# Geo IP data for SI-Proxy
## Maintenance
We use the Free GeoLite2 database. You'll find the most recent version to download on their [Website](https://dev.maxmind.com/geoip/geoip2/geolite2/#Downloads). 
### Updating Geo locations
 
1. When you download the database it will have a date suffix in the filename.
1. Update the VERSION in the Dockerfile with the date from the suffix

### Mapping a Property
1. Find the field name you need in the CSV file
1. Run `node index` with the CSV that contains it and the property as a last argument. You'll find examples of this in the `Dockerfile`

### Releasing a new Version
Every tagged version will be published. The tag should reflect the database used: 

```bash
git tag 2018-02-06
git push --tags
```

Tagged versions are published to [Dockerhub](https://hub.docker.com/r/smallimprovements/si-proxy-geoip-data)
