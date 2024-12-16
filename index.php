<?php
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use Slim\Factory\AppFactory;
use Slim\Views\PhpRenderer;

require 'vendor/autoload.php';

$app = AppFactory::create();

$app->get('/', function (Request $request, Response $response, array $args) {
  $renderer = new PhpRenderer('templates/');
  return $renderer->render($response, "application.phtml", $args);
});

$app->run();
