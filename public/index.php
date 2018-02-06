<?php  
require '../vendor/autoload.php';  
require '../src/models/Photo.php'; 
require '../src/models/Partie.php';
require '../src/models/Serie.php';
require '../src/handlers/exceptions.php';

use Ramsey\Uuid\Uuid;
use Ramsey\Uuid\Exception\UnsatisfiedDependencyException;

header("Access-Control-Allow-Origin: http://geoquizz.kojuri.com");

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

$app->post('/stop/{token}[/]', function($request, $response, $args) {
    $token = $args['token'];
    $partie = Partie::select()
                ->where('token', '=', $token)
                ->first();
    if($partie){
        if($partie->statut != 1){
            return $response->withStatus(409);
        }
        else{
            $partie->statut = 2;
            $data = $request->getParsedBody();
            $partie->score = $data['score'];
            $partie->save();
            return $response->withStatus(200);
        }      
    }
    else{
        return $response->withStatus(403);
    }
});

$app->put('/play/{token}[/]', function($request, $response, $args) {
    $token = $args['token'];
    $partie = Partie::select()
                ->where('token', '=', $token)
                ->first();
    if($partie){
        if($partie->statut != 2){
            return $response->withStatus(409);
        }
        else{
            $partie->statut = 1;
            $partie->save();
            return $response->withStatus(200);
        }      
    }
    else{
        return $response->withStatus(403);
    }
});

$app->post('/end/{token}[/]', function($request, $response, $args) {
    $token = $args['token'];
    $partie = Partie::select()
                ->where('token', '=', $token)
                ->first();
    if($partie){
        if($partie->statut != 1){
            return $response->withStatus(409);
        }
        else{
            $partie->statut = 3;
            $data = $request->getParsedBody();
            $partie->score = $data['score'];
            $partie->save();
            return $response->withStatus(200);
        }      
    }
    else{
        return $response->withStatus(403);
    }
});

$app->run();