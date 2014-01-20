var http = require('http'),
	express = require('express'),
	hbs = require('express-hbs'),
	app = new express(),
	config = require('./config.json')[app.get('env')];

// Register the HBS template engine.
// Use `.hbs` for extensions and find partials in `views/partials`.
app.engine('hbs', hbs.express3({
	partialsDir: __dirname + '/views/partials',
	layoutsDir: __dirname + '/views/layouts',
	defaultLayout: __dirname + '/views/layouts/default.hbs'
}));

// Set the view engine
app.set('view engine', 'hbs');
app.set('views', __dirname + '/views');

// Mark the `public` dir as a static dir.
// All static files (css/js/img) are accessible from the `public` folder.
app.use(express.static('./public'));

// Set local variables that are available to all views/templates
app.locals({
	production: app.get('env') === 'production'
});

// Add some useful middleware
app.use(express.responseTime());
app.use(app.router);
app.use(express.errorHandler());

// Create route.
app.get('/', function (req, res) {
	res.render('index', {
		title: 'Awesome!',
		message: 'Your node server is running.'
	});
});

// Start the server.
http.createServer(app).listen(config.port, function () {
	console.log('App started on port ' + config.port);
});
