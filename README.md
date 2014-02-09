Installation
------------

First run `vagrant up` which will setup the server for the first time and perform provisioning by installing all necessary software.

	cd /path/to/project/dir
	vagrant up

Now, ssh into the server.

	vagrant ssh

Move to the application root directory `/vagrant` and install all dependency modules.

	cd /vagrant
	npm install

Now, exit from the server.

	exit

Reboot the server so that `upstart` kicks-off the node app at startup.

	vagrant reload

Now browse to `http://192.168.50.100/`. And you should see an "Awesome!" message.


References
----------

- [Deploying Node.js With Upstart and Monit](http://howtonode.org/deploying-node-upstart-monit)
- [Node.js production deployment with Nginx, Varnish, Upstart and Monit](http://blog.dealspotapp.com/post/40184153657/node-js-production-deployment-with-nginx-varnish)
- [Control Node.Js server using upstart/monit](http://darktalker.com/2011/load-balancer-nodejs-startupmonit/)
- [Running node.js Apps with Upstart](https://github.com/cvee/node-upstart/blob/master/README.md)
- [Node.js production deployment with Nginx, Varnish, Upstart and Monit](http://blog.dealspotapp.com/post/40184153657/node-js-production-deployment-with-nginx-varnish)
- [Install Node.js and Express.js with Nginx on Debian Lenny](http://www.freshblurbs.com/blog/2011/05/07/install-node-js-and-express-js-nginx-debian-lenny.html)
- [Installing Express for Node.JS on Ubuntu 12.04](http://www.rubynginx.com/index.php/2012/10/02/installing-express-for-node-js-on-ubuntu-12-04/)
- [GitHub Gist for inslatting Nodejs, Nginx, MongoDB and Redis](https://gist.github.com/natestarner/1998987)
