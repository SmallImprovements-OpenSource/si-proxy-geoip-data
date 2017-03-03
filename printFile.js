const fs = require('fs');
const { parse, transform } = require('csv');

module.exports = printFile;

function printFile(locations, file) {
    fs.createReadStream(file)
        .pipe(parse({ columns: true }))
        .pipe(transform(record => locations[record.geoname_id] && `${record.network} ${locations[record.geoname_id]}\n`))
        .pipe(process.stdout);
}
