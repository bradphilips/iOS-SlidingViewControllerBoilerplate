iOS-SlidingViewControllerBoilerplate
====================================

Boilerplate sliding view controller template based on Mike Enriquez's awesome [ECSlidingViewController](https://github.com/edgecase/ECSlidingViewController) and Matt Gallagher's beautiful [re-usable tableview article](http://www.cocoawithlove.com/2010/12/uitableview-construction-drawing-and.html).

This also builds upon some 'best practices' I have used in the past to create modular and re-usable mobile apps for such as servicing layers, model mapping, and view-logic separation.

### _Dummy Server Technology_

This application also has an accompanying localhost server that is written in Node to allow sandbox development and mock out service calls.  The only functions implemented now are login and logout.  The resources are as follows:

		POST 	/session - Login user { username:'brad', password: 'secure' }
		DELETE 	/session - Logout user

* [Node](http://nodejs.org/) - Node is an evented server side technology built in javascript (using Google's V8 engine).  This is a very fast lightweight server-side technology and is rapidly becoming very popular.

**Setup**

1.  Get and install [nvm (Node Version Manager)](https://github.com/creationix/nvm)
2.  Run `nvm install v0.10.0`
3.  In the base of the `Server` directory run `npm install`
4.  Run `node app.js`