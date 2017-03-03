const fs = require('fs');
const { parse } = require('csv');

module.exports = getLocations;

function getLocations(file, property) {
    return new Promise((resolve, reject) => {
        const map = {};
        fs.createReadStream(file)
            .pipe(parse({ columns: true }))
            .on('data', record => map[record.geoname_id] = record[property])
            .on('end', () => resolve(map))
            .on('error', error => reject(error));
    });
}
