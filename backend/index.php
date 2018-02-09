<?php  
require '../vendor/autoload.php';  
require '../src/models/Photo.php'; 
require '../src/models/Serie.php';
require 'src/geoquizz/auth/GeoquizzAuthentification.php';
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
    
    // Variables globales twig avec le mail et le pseudo de l'utilisateur connecté
    if(isset($_SESSION['mail']) and isset($_SESSION['user_login'])){
        $view->getEnvironment()->addGlobal("mail", $_SESSION['mail']);
        $view->getEnvironment()->addGlobal("pseudo", $_SESSION['user_login']);
    }

    return $view;
};

// Document root de l'application utilisé pour les redirections
$app->root = dirname($_SERVER['SCRIPT_NAME'],1);

// Route affichant le formulaire d'inscription
$app->get('/inscription[/]', function ($request, $response, $args) {
    return $this->view->render($response, 'inscription.html', $args);
});

// Route validant l'inscription
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
               header("Location: ".$app->root."/connexion");
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

// Route affichant le formulaire de connexion
$app->get('/connexion[/]', function ($request, $response, $args) {
    return $this->view->render($response, 'connexion.html', $args);
});

// Route validant la connexion
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
            header("Location: ".$app->root."/accueil");
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

// Route affichant la page d'accueil de l'application backend
$app->get('/accueil[/]', function ($request, $response, $args) {
    if(isset($_SESSION['mail']) and isset($_SESSION['user_login'])){
        return $this->view->render($response, 'accueil.html');
    }
    else{
        return $this->view->render($response, 'connexion.html');
    }
});

// Route permettant de se déconnecter
$app->get('/deconnexion[/]', function ($request, $response, $args) use ($app){
    $auth = new GeoquizzAuthentification();
    $auth->deconnexion();
    header("Location: ".$app->root."/accueil");
    exit();
});

// Route affichant la liste des séries
$app->get('/series[/]', function ($request, $response, $args) use ($app){
    $lesSeries = Serie::all();
    if(isset($_SESSION['mail']) and isset($_SESSION['user_login'])){
        return $this->view->render($response, 'series.html', array(
            'series' => $lesSeries
            ));
    }
    else{
        header("Location: ".$app->root."/accueil");
        exit();
    }
});

// Route affichant une série et ses photos
$app->get('/serie/{id}[/]', function ($request, $response, $args) use ($app){
    $uneSerie = Serie::find($args['id']);
    if(isset($_SESSION['mail']) and isset($_SESSION['user_login'])){
        return $this->view->render($response, 'serie.html', array(
            'serie' => $uneSerie
            ));
    }
    else{
        header("Location: ".$app->root."/accueil");
        exit();
    }
});

// Route affichant le formulaire d'ajout d'une série
$app->get('/ajouterSerie[/]', function ($request, $response, $args) use($app){
    if(isset($_SESSION['mail']) and isset($_SESSION['user_login'])){
        return $this->view->render($response, 'ajouterSerie.html');
    }
    else{
        header("Location: ".$app->root."/accueil");
        exit();
    }
});

// Route validant l'ajout d'une série
$app->post('/addSerie[/]', function($request, $response, $args) use ($app){
    if(isset($_SESSION['mail']) and isset($_SESSION['user_login'])){
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

            header("Location: ".$app->root."/serie/".$serie->id);
            exit();
        }
        else{
            return $this->view->render($response, 'ajouterSerie.html', [
                'error' => 'Veuillez remplir tous les champs !'
            ]);
        }
    }
    else{
        header("Location: ".$app->root."/accueil");
        exit();
    }
});

// Route affichant le formulaire d'ajout d'une photo à une série
$app->get('/ajouterPhoto/{serie_id}[/]', function ($request, $response, $args) use($app){
    if(isset($_SESSION['mail']) and isset($_SESSION['user_login'])){  
        $serie = Serie::find($args['serie_id']); 
        return $this->view->render($response, 'ajouterPhoto.html', array(
            'serie' => $serie
            ));
    }
    else{
        header("Location: ".$app->root."/accueil");
        exit();
    }
});

// Route validant l'ajout d'une photo à une série
$app->post('/addPhoto/{serie_id}[/]', function($request, $response, $args) use ($app){
    $serie_id = $args['serie_id'];
    if(isset($_SESSION['mail']) and isset($_SESSION['user_login'])){
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

            header("Location: ".$app->root."/serie/".$serie_id);
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
        header("Location: ".$app->root."/accueil");
        exit();
    }
});

// Lance l'application
$app->run();