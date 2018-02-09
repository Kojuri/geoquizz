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
$app->options('/{routes:.+}', function ($request, $response, $args) {
    return $response;
});
$app->add(function ($req, $res, $next) {
    $response = $next($req, $res);
    return $response
            ->withHeader('Access-Control-Allow-Origin', '*')
            ->withHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept, Origin, Authorization')
            ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
});
$app->post('/start[/]', function($request, $response, $args) {
    $data = $request->getParsedBody();
    $partie = new Partie();
    $partie->joueur = $data['joueur'];
    $uuid4 = Uuid::uuid4();
    $token = $uuid4->toString();
    $partie->token = $token;
    $partie->statut = 0;
    $partie->score = 0;
    $partie->serie_id = 1;  
    $partie->save();
    $rep = array();
    $rep['token'] = $token;
    $serie = Serie::find($partie->serie_id);
    $rep['serie'] = $serie;
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
$app->get('/start/{token}[/]', function($request, $response, $args) {
    $token = $args['token'];
    $partie = Partie::select()
                ->where('token', '=', $token)
                ->first();
    if($partie){
        if($partie->statut != 0){
            return $response->withStatus(409);
        }
        else{
            $partie->statut = 1;
            $partie->save();
            $serie = Serie::find($partie->serie_id);        
            $photos = $serie->photos()->get();
            $array = json_decode(json_encode($photos), true);
            shuffle($array);
            $output = array_slice($array, 0, 10);
            $json = json_encode($output);
            return $response->withStatus(200)->getBody()->write($json);
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
// Catch-all route to serve a 404 Not Found page if none of the routes match
// NOTE: make sure this route is defined last
$app->map(['GET', 'POST', 'PUT', 'DELETE', 'PATCH'], '/{routes:.+}', function($req, $res) {
    $handler = $this->notFoundHandler; // handle using the default Slim page not found handler
    return $handler($req, $res);
});
$app->run();