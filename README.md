#API GéoQuizz


POST/public/start

Description : Permet de démarrer la partie.

Params : {"joueur": ...}

Retourne : {"token": ...,"serie":{"id": ...,"lieu": ...,"lieu_longitude": ...,"lieu_latitude": ...,"zoom_carte": ...,"distance_calcul": ...},"photos":[{"id": ...,"desc": ...,"longitude": ...,"latitude": ...,"url": ...,"serie_id": ...}, ...]}


POST/public/stop/?token=:token

Description : Permet de mettre en pause la partie.

Params : {"score": ...}


PUT/public/play/ ?token=:token

Description : Permet de reprendre la partie.

Params :  Aucun paramètre supplémentaire requis


POST/public/end/ ?token=:token
Description : Enregistre le score si demandé et termine la partie.
Params : {"score": ...}
