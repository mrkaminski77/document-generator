// make sure the path to the node module is correct
fs = require('fs')

var md = require('C:\\Users\\dleyden\\node_modules\\markdown-it')({
  html: true
});

fs.readFile(process.argv[2], 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
  
  fs.writeFile(process.argv[3], md.render(data));
});


