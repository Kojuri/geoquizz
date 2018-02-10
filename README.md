#API GéoQuizz


POST/public/start

Description : Permet de démarrer la partie.

Params : {"joueur": ...}

Retourne : {"token": ...,"serie":{"id": ...,"lieu": ...,"lieu_longitude": ...,"lieu_latitude": ...,"zoom_carte": ...,"distance_calcul": ...},"photos":[{"id": ...,"desc": ...,"longitude": ...,"latitude": ...,"url": ...,"serie_id": ...}, ...]}


GET/public/start/?token=:token

Description : Permet de récupérer les photos de la partie.

Params :  Aucun paramètre supplémentaire requis

Retourne : {"photos":[{"id": ...,"desc": ...,"longitude": ...,"latitude": ...,"url": ...,"serie_id": ...}, ...]}


POST/public/stop/?token=:token

Description : Permet de mettre en pause la partie.

Params : {"score": ...}


PUT/public/play/ ?token=:token

Description : Permet de reprendre la partie.

Params :  Aucun paramètre supplémentaire requis


POST/public/end/ ?token=:token

Description : Enregistre le score si demandé et termine la partie.

Params : {"score": ...}


Statut d'une partie

0 : La partie est initiée.

1 : La partie est en cours.

2 : La partie est en pause.

3 : La partie est terminée.
