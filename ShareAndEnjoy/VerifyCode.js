
var fs = require('fs');
var spawn = require('child_process').spawn;

var sHtml = fs.readFileSync('./index.html').toString();

// Apparently [^] can be used as a "multi-line dot".  Bleurgh!
var regexp = new RegExp('<script[^/][^>]*>([^]*?)</script[^>]*>', 'gim');

var sMainScript = sHtml.match(regexp).pop();

// Now remove the first and last line
var arr = sMainScript.split('\n');
arr.pop();
arr.shift();
sMainScript = arr.join('\n');

fs.writeFileSync('./ShareAndEnjoy.ts', sMainScript);

var compiler = spawn('tsc.cmd', ['./ShareAndEnjoy.ts']);

compiler.stdout.on('data', function(data)
{
    process.stdout.write(data.toString());
});
    
compiler.stderr.on('data', function(data)
{
    process.stdout.write(data.toString());
});
