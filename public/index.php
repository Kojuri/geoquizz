<?php  
require '../vendor/autoload.php';  
require '../src/models/Photo.php'; 
require '../src/models/Partie.php';
require '../src/models/Serie.php';
require '../src/handlers/exceptions.php';

use Ramsey\Uuid\Uuid;
use Ramsey\Uuid\Exception\UnsatisfiedDependencyException;

$config = include('../src/config.php');

$app = new \Slim\App(['settings'=> $config]);

$container = $app->getContainer();

$capsule = new \Illuminate\Database\Capsule\Manager;
$capsule->addConnection($container['settings']['db']);
$capsule->setAsGlobal();
$capsule->bootEloquent();

$capsule->getContainer()->singleton(
  Illuminate\Contracts\Debug\ExceptionHandler::class,
  App\Exceptions\Handler::class
);
$app->get('/photos[/]', function($request, $response) {
    return $response->getBody()->write(Photo::all()->toJson());
});

$app->get('/token[/]', function($request, $response) {
   
    return $response->getBody()->write($token);
});

$app->post('/start[/]', function($request, $response, $args) {
    $data = $request->getParsedBody();
    $partie = new Partie();
    $partie->joueur = $data['joueur'];
    $uuid4 = Uuid::uuid4();
    $token = $uuid4->toString();
    $partie->token = $token;
    $partie->statut = 1;
    $partie->score = 0;
    $partie->serie_id = 1;  
    $partie->save();
  
    $rep = array();
    $rep['token'] = $token;

    $serie = Serie::find($partie->serie_id);
    $rep['serie'] = $serie;

    $photos = $serie->photos()->get();
    $array = json_decode(json_encode($photos), true);
    shuffle($array);
    $rep['photos'] = $array;

    $json = json_encode($rep);
    return $response->withStatus(201)->getBody()->write($json);
});

$app->run();