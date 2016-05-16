var net = require('net');

var server = net.createServer(function(connection) {
  console.log('client connected');

  connection.on('end', function() {
    console.log('client disconnected');
  });

  connection.on('data', function(data) {
    dataString = data.toString().trim();

    if (dataString.match(/exit/)) {
      connection.write('Goodbye!\r\n');
      connection.end();
    }
    else {
      connection.write(cmdr(dataString) + '\r\n');
      connection.write('\r\n> ');
    }
  });

  connection.write('> ');
});

var cmdr = require('text-commander')([
  {
    'look at {thing}': (obj) => {
      console.log('client looked at ' + obj.thing);
      return `looking at ${obj.thing}.`
    }
  },
  {
    'use {thing} on {otherThing}': (obj) => {
      console.log('client used ' + obj.thing + ' on ' + obj.otherThing);
      return `using ${obj.thing} on ${obj.otherThing}.`
    }
  }
])

server.listen(1337, function() {
  console.log('server is listening');
});
