<?php

require 'src\geoquizz\model\Utilisateur.php';
require 'src\mf\auth\Authentification.php';


class GeoquizzAuthentification extends \mf\auth\Authentification {

    /* constructeur */
    public function __construct(){
        parent::__construct();
    }

    public function createUtilisateur($pseudo, $mdp, $mail) 
    {  
        $requete = Utilisateur::select()->where('mail', '=', $mail);
        $unUtilisateur = $requete->first();
        if(!is_null($unUtilisateur)){
            return "Email déjà utilisé";
        }
        else{
            $u = new Utilisateur();
            $u->pseudo = $pseudo;
            $u->mail = $mail;
            $hash = $this->hashPassword($mdp);
            $u->mdp = $hash;
            $u->save();
        }
    }

    public function login($mail, $mdp)
    { 
        $requete = Utilisateur::select()->where('mail', '=', $mail);
        $unUtilisateur = $requete->first();
        if(is_null($unUtilisateur))
        {
            return "Utilisateur inconnu";
        }
        else{
            $requete = Utilisateur::select()
            ->where('mail', '=', $mail)
            ;
            $p = $requete->first();
            $check = $this->verifyPassword($mdp, $p->mdp);
              
            if($check == false){
                return "Mot de passe erroné !";
            }
            else{
                $this->updateSession($p->pseudo, $mail);
            }
        }
    }
    public function deconnexion(){
        $this->logout();
    }
}
