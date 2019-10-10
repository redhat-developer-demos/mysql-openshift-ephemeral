const version = '1.0';

const express = require('express');
const app = express();
const cors = require('cors');
const http = require('http');
const bodyParser = require('body-parser');
const port = 8080;
const mysql = require('mysql');

var connection = mysql.createConnection({
  host     : process.env.MYSQL_HOST,
  user     : process.env.MYSQL_USER,
  password : process.env.MYSQL_PASSWORD,
  database : process.env.MYSQL_DATABASE
});


connection.connect(function(err) {
  if (err) {
    return console.log('error:' + err.message);
  }
  console.log('getCustomer microservice is now connected with mysql database...')
})

app.use(cors());
app.use(bodyParser.json() );       // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: true
}));

app.get('/', (req, res) => res.send(`getCustomer version ${version}`))


//rest api to get a single customer data
app.get('/customer/:id', function (req, res) {
  connection.query('select * from customer where id=?', [req.params.id], function (error, results, fields) {
   if (error) throw error;
   res.end(JSON.stringify(results[0]));
 });
});

var server = app.listen(port, "0.0.0.0", function () {

  var host = server.address().address
  console.log('connecting to ' + process.env.MYSQL_HOST)

  console.log("getCustomer microservice is listening at http://%s:%s", host, port)

});