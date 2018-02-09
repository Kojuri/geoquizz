<?php  
require '../vendor/autoload.php';  
require '../src/models/Photo.php'; 
require '../src/models/Serie.php';
require 'src/geoquizz/auth/GeoquizzAuthentification.php';
//require 'src/geoquizz/model/Utilisateur.php';
require '../src/handlers/exceptions.php';

use Ramsey\Uuid\Uuid;
use Ramsey\Uuid\Exception\UnsatisfiedDependencyException;

session_start();

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

// Register component on container
$container['view'] = function ($container) {
    $view = new \Slim\Views\Twig('src/geoquizz/view', [
        'cache' => false
    ]);

    // Instantiate and add Slim specific extension
    $basePath = rtrim(str_ireplace('index.php', '', $container['request']->getUri()->getBasePath()), '/');
    $view->addExtension(new Slim\Views\TwigExtension($container['router'], $basePath));
    $root = dirname($_SERVER['SCRIPT_NAME'],1);
    $view->getEnvironment()->addGlobal("root", $root);
    return $view;
};



// Render Twig template in route
$app->get('/inscription[/]', function ($request, $response, $args) {
    return $this->view->render($response, 'inscription.html', $args);
});

$app->post('/register[/]', function($request, $response, $args) use ($app){
    $data = $request->getParsedBody();
    if(!empty($data['pseudo']) and !empty($data['mail']) and !empty($data['mdp'])and !empty($data['remdp']))
    {
        $mail = filter_var($data['mail'], FILTER_SANITIZE_SPECIAL_CHARS);
        $pseudo = filter_var($data['pseudo'], FILTER_SANITIZE_SPECIAL_CHARS);
        $mdp = filter_var($data['mdp'], FILTER_SANITIZE_SPECIAL_CHARS);
        $remdp = filter_var($data['remdp'], FILTER_SANITIZE_SPECIAL_CHARS);
        $auth = new GeoquizzAuthentification();
        if($mdp == $remdp)
        {
            $co = $auth->createUtilisateur($pseudo, $mdp, $mail);
            if(empty($co))
            {                
               header("Location: connexion");
               exit();
            }
            else
            {
               return $this->view->render($response, 'inscription.html', [
                    'error' => $co
                ]);
            }
        }
        else 
        {
            return $this->view->render($response, 'inscription.html', [
                'error' => 'Les deux mots de passe ne sont pas identiques !'
            ]);
        }
    }
    else{
        return $this->view->render($response, 'inscription.html', [
            'error' => 'Veuillez remplir tous les champs !'
        ]);
    }
});

$app->get('/connexion[/]', function ($request, $response, $args) {
    return $this->view->render($response, 'connexion.html', $args);
});

$app->post('/login[/]', function($request, $response, $args) use ($app){
    $data = $request->getParsedBody();
    if(!empty($data['mail']) and !empty($data['mdp']))
    {
        $mail = filter_var($data['mail'], FILTER_SANITIZE_SPECIAL_CHARS);
        $mdp = filter_var($data['mdp'], FILTER_SANITIZE_SPECIAL_CHARS);
        $auth = new GeoquizzAuthentification();
        $co = $auth->login($mail, $mdp);
        if(empty($co))
        {
            header("Location: accueil");
            exit();
        }
        else
        {
            return $this->view->render($response, 'connexion.html', [
                'error' => $co
            ]);
        }
    }
    else{
        return $this->view->render($response, 'connexion.html', [
            'error' => 'Veuillez remplir tous les champs !'
        ]);
    }
});

$app->get('/accueil[/]', function ($request, $response, $args) {
    if(isset($_SESSION['mail']) and isset($_SESSION['user_login'])){
        return $this->view->render($response, 'accueil.html', array(
            'pseudo' => $_SESSION['user_login'], 
            'mail' => $_SESSION['mail']
            ));
    }
    else{
        return $this->view->render($response, 'connexion.html');
    }
});

$app->get('/deconnexion[/]', function ($request, $response, $args) {
    $auth = new GeoquizzAuthentification();
    $auth->deconnexion();
    header("Location: accueil");
    exit();
});

$app->get('/series[/]', function ($request, $response, $args) {
    $lesSeries = Serie::all();
    if(!is_null($_SESSION['mail']) and !is_null($_SESSION['user_login'])){
        return $this->view->render($response, 'series.html', array(
            'pseudo' => $_SESSION['user_login'], 
            'mail' => $_SESSION['mail'],
            'series' => $lesSeries
            ));
    }
    else{
        header("Location: accueil");
        exit();
    }
});

$app->get('/serie/{id}[/]', function ($request, $response, $args) {
    $uneSerie = Serie::find($args['id']);
    if(!is_null($_SESSION['mail']) and !is_null($_SESSION['user_login'])){
        return $this->view->render($response, 'serie.html', array(
            'pseudo' => $_SESSION['user_login'], 
            'mail' => $_SESSION['mail'],
            'serie' => $uneSerie
            ));
    }
    else{
        header("Location: accueil");
        exit();
    }
});

$app->get('/ajouterSerie[/]', function ($request, $response, $args) {
    if(!is_null($_SESSION['mail']) and !is_null($_SESSION['user_login'])){
        return $this->view->render($response, 'ajouterSerie.html', array(
            'pseudo' => $_SESSION['user_login'], 
            'mail' => $_SESSION['mail'],
            ));
    }
    else{
        header("Location: accueil");
        exit();
    }
});

$app->post('/addSerie[/]', function($request, $response, $args) use ($app){
    if(!is_null($_SESSION['mail']) and !is_null($_SESSION['user_login'])){
        $data = $request->getParsedBody();
        if(!empty($data['longitude']) and !empty($data['latitude']) and !empty($data['lieu']) and !empty($data['zoom']) and !empty($data['dist']))
        {
            $longitude = filter_var($data['longitude'], FILTER_SANITIZE_SPECIAL_CHARS);
            $latitude = filter_var($data['latitude'], FILTER_SANITIZE_SPECIAL_CHARS);
            $lieu = filter_var($data['lieu'], FILTER_SANITIZE_SPECIAL_CHARS);
            $zoom = filter_var($data['zoom'], FILTER_SANITIZE_SPECIAL_CHARS);
            $dist = filter_var($data['dist'], FILTER_SANITIZE_SPECIAL_CHARS);
            
            $serie = new Serie();
            $serie->lieu = $lieu;
            $serie->lieu_longitude = $longitude;
            $serie->lieu_latitude = $latitude;
            $serie->zoom_carte = $zoom;
            $serie->distance_calcul = $dist;
            $serie->save();

            header("Location: serie/".$serie->id);
            exit();
        }
        else{
            return $this->view->render($response, 'ajouterSerie.html', [
                'error' => 'Veuillez remplir tous les champs !'
            ]);
        }
    }
    else{
        header("Location: accueil");
        exit();
    }
});
$app->get('/ajouterPhoto/{serie_id}[/]', function ($request, $response, $args) {
    if(!is_null($_SESSION['mail']) and !is_null($_SESSION['user_login'])){   
        $serie = Serie::find($args['serie_id']); 
        return $this->view->render($response, 'ajouterPhoto.html', array(
            'pseudo' => $_SESSION['user_login'], 
            'mail' => $_SESSION['mail'],
            'serie' => $serie
            ));
    }
    else{
        header("Location: accueil");
        exit();
    }
});

   
$app->post('/addPhoto/{serie_id}[/]', function($request, $response, $args) use ($app){
    $serie_id = $args['serie_id'];
    if(!is_null($_SESSION['mail']) and !is_null($_SESSION['user_login'])){
        $data = $request->getParsedBody();
        if(!empty($data['longitude']) and !empty($data['latitude']) and !empty($data['desc']) and !empty($data['url']))
        {
            $longitude = filter_var($data['longitude'], FILTER_SANITIZE_SPECIAL_CHARS);
            $latitude = filter_var($data['latitude'], FILTER_SANITIZE_SPECIAL_CHARS);
            $desc = filter_var($data['desc'], FILTER_SANITIZE_SPECIAL_CHARS);
            $url = filter_var($data['url'], FILTER_SANITIZE_SPECIAL_CHARS);
            
            $photo = new Photo();
            $photo->desc = $desc;
            $photo->longitude = $longitude;
            $photo->latitude = $latitude;
            $photo->url = $url;
            $photo->serie_id = $serie_id;
            $photo->save();
            $root = dirname($_SERVER['SCRIPT_NAME'],1);
            header("Location: ".$root."/serie/".$serie_id);
            exit();
        }
        else{
            $serie = Serie::find($serie_id); 
            return $this->view->render($response, 'ajouterPhoto.html', [
                'error' => 'Veuillez remplir tous les champs !',
                'serie' => $serie
            ]);
        }
    }
    else{
        header("Location: accueil");
        exit();
    }
});

// Catch-all route to serve a 404 Not Found page if none of the routes match
// NOTE: make sure this route is defined last
$app->map(['GET', 'POST', 'PUT', 'DELETE', 'PATCH'], '/{routes:.+}', function($req, $res) {
    $handler = $this->notFoundHandler; // handle using the default Slim page not found handler
    return $handler($req, $res);
});

$app->run();