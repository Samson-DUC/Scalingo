# Sample PHP/NodeJS application

## PHP

The `slim` microframework is used to handle the PHP part

## NodeJS

NodeJS is installed to install/build assets. If you want the assets to be built on deployment time,
you have to add the tools you're using to the dependencies of your app:

```bash
npm install bower --save
npm install gulp --save
git add package.json
git commit -m "Set bower and gulp as dependencies"
```

The different tasks are specified in the `composer.json` file of the PHP project

```json
{
  …
  "extra": {
    "paas": {
      "compile": [
        "node_modules/.bin/bower install",
        "node_modules/.bin/gulp bundle"
      ]
    }
  }
}
```

## Deployment

* Install http://cli.scalingo.com

```
scalingo create my-app
scalingo --app my-app env-set DOCUMENT_ROOT=/
git push scalingo master
```

> Usually the buildpack is chosen automatically, but as this application is using two distinct technologies, it has to be specified.

That's it your app is live.

http://sample-php-nodejs.scalingo.io
