const getLocations = require('./getLocations');
const printFile = require('./printFile');

const { argv } = process;
const [ blockFile, locationFile, property ] = argv.slice(2);

getLocations(locationFile, property)
    .then(locations => printFile(locations, blockFile));


