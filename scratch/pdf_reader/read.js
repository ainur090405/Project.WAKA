const fs = require('fs');
const pdf = require('pdf-parse');

let dataBuffer = fs.readFileSync('../../Pertemuan 12 auto scalling.pdf');

pdf(dataBuffer).then(function(data) {
    fs.writeFileSync('../pdf_output.txt', data.text);
    console.log("PDF extraction complete.");
}).catch(err => console.error(err));
