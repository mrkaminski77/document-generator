////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// convert.js
//
// a support routine to use markdown-it via node-js
// The module will read all arguments from the command line and if the path exists attempt to render markdown as html.
//

var fs = require('fs')

// make sure the path to the node module is correct
var md = require('C:\\Users\\dleyden\\node_modules\\markdown-it')({
  html: true
});

for(var i = 2; i < process.argv.length; i++){
  var p = process.argv[i]
  console.log(p)
  fs.stat(p, function(err, stat) {
      if(err == null) {
          console.log('File exists');
          fs.readFile(p, 'utf8', function (err,data) {
            if (err) {
              return console.log(err);
            }
            fs.writeFile(p + '.html', md.render(data));
          });

        } else if(err.code == 'ENOENT') {
          // file does not exist
          fs.writeFile('log.txt', 'Some log\n');
      } else {
          console.log('Some other error: ', err.code);
      }
  });
}
