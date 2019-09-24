const http = require('http');
const process = require('process');

const server = http.createServer((req, res) => {
  res.end('Hello world!');
});

server.on('clientError', (err, socket) => {
  socket.end('HTTP/1.1 400 Bad Request\r\n\r\n');
});

server.listen(process.env.PORT, function () {
    console.log('listening', this.address())
});
