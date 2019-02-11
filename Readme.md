# Geo IP data for SI-Proxy
## Maintenance
We use the Free GeoLite2 database. You'll find the most recent version to download on their [Website](https://dev.maxmind.com/geoip/geoip2/geolite2/#Downloads). 
### Updating Geo locations
 
1. When you download the database it will have a date suffix in the filename.
2. Update the VERSION in the Dockerfile with the date from the suffix

### Mapping a Property
1. Add the field you need to `PROPERTIES` in the dockerfile. When the container is build it will be extracted to `field.map`

### Releasing a new Version
Every tagged version will be published. The tag should reflect the database used: 

```bash
git tag 2018-02-06
git push --tags
```
