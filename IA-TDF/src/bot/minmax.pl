:- consult('etat.pl').

% PlayerWhoPlay 





/******* MAX MAX *******/
% maxMax()
% StateInit : Etat de base qu'on récupère du fichier etat
% Depth : profondeur (3)
% BestMove : meilleur noeud enfant
% BestValue: meilleur valeur parmi les valeurs
%
% Obtenir la liste des coups possibles pour le joueur actuel
% Générer les états pour chaque coup et les évaluer en utilisant la fonction best/3
% Sélectionner le coup ayant la meilleure valeur d'évaluation
% Mettre à jour BestMove et BestValue en fonction du coup choisi
% (Appeler bestOf/3 pour récupérer la meilleure valeur parmi les valeurs des coups des autres joueurs).

/***********************/




/******* BEST MOVE *******/
% bestMove(State, Depth, BestValue)
% State : l'état actuel du jeu
% Depth : profondeur (3)
% BestValue: meilleur valeur parmi les valeurs
%
% Vérifier si l'état est un état terminal (profondeur atteinte ou partie terminée)
% Si c'est un état terminal, évaluer l'état en utilisant une fonction d'évaluation heuristique
% Sinon, explorer les coups possibles pour le joueur actuel en utilisant maxMax/4
% Mettre à jour BestValue en fonction des valeurs renvoyées par maxMax/4 pour chaque coup.

/**************************/



/******* BETTER OF *******/
% betterOf([PlayerId|RestPlayers], State, Depth, Moves, [BestMove|BestMoves])
% [PlayerId|RestPlayers] : liste représentant les joueurs encore actifs dans le jeu. PlayerId est le premier élément de la liste et représente l'identifiant du joueur actuel
% State : l'état actuel du jeu
% Depth : profondeur (3)
% Moves : liste contenant les coups possibles que le joueur actuel peut jouer à partir de l'état actuel
% [BestMove|BestMoves] : liste contenant les meilleurs coups pour le joueur actuel et les autres joueurs
%   BestMove représente le meilleur coup que le joueur actuel peut jouer à partir de l'état actuel
%   BestMoves est une liste contenant les meilleurs coups pour les autres joueurs (qui n'ont pas encore joué).
%
% Obtenir les coups possibles pour le joueur PlayerId
% Générer les états pour chaque coup et les évaluer en utilisant la fonction best/3
% Sélectionner le coup ayant la meilleure valeur d'évaluation pour ce joueur (BestMove)
% Appeler récursivement bestOf/3 pour les autres joueurs (RestPlayers) et récupérer les meilleurs coups (BestMoves).

/*************************/



/******* EVALUATE *******/
% evaluate(Node, Value) : renvoie la valeur d'un état donné suivant une heuristique
% State : l'état actuel du jeu?
% Value : [Val1, Val2, Val3, Val4]
%
% Chute : val - 20
% Case chance : Val - 3                     OK
% Ligne arrivé (102) : Val + 20             OK
% Case supplémentaire (103 - 112): Val      OK
% Case vierge : Val                         
% Case 89 - 102 : Val + 2                   OK


player([Belgique, Italie, Hollande, Allemagne, PlayerCurrent], [Val1, Val2, Val3, Val4]) :-
    player_eval(Belgique, Val1),
    player_eval(Italie, Val2),
    player_eval(Hollande, Val3),
    player_eval(Allemagne, Val4).
    
player_eval([[Coureur1, Coureur2, Coureur3], Cards], Val):-
    writeln("Cy "+Coureur1),writeln("Cartes" +Cards),
    %cyclist_eval(Coureur, Cards, Val).
    cyclist_eval(Coureur1, Cards, Val1),
    cyclist_eval(Coureur2, Cards, Val2),
    cyclist_eval(Coureur3, Cards, Val3),
    Val is Val1 + Val2 + Val3.


player_eval([[Coureur | AutreCoureur], Cards], Val1):-
    cyclist_eval(Coureur, Cards, Val2),
    player_eval([[AutreCoureur], Cards], Val3),
    Val1 is Val2 + Val3.

    
% Global 
cyclist_eval((Ligne, Colonne), Cards, Val) :-
    \+ case_chance(Ligne, Colonne), % Vérifie si la case n'est pas une "case chance"
    \+ is_case_supplementaire(Ligne), % Vérifie si la case n'est pas une "case supplementaire"
    \+ exclude_lines(Ligne), % Vérifie que la ligne n'est pas comprise entre 89 et 102
    Ligne =\= 102, % Vérifie si la case n'est pas la case finale
    writeln("TEST AFTER case vierge "+Ligne + Colonne),
    Val is 0. % Exemple d'évaluation pour une case non chance TODO: Mettre ligne ?

% Exclure les lignes comprises entre 89 et 102
exclude_lines(Ligne) :- Ligne >= 89, Ligne =< 102.

% Ligne 102
cyclist_eval((102, Colonne), Cards, Val) :- 
    writeln("Ligne 102"),
    Val is 20.

% Case supplémentaire
cyclist_eval((Ligne, Colonne), Cards, Val) :- 
    writeln("TEST BEFORE "+Ligne + Colonne),
    is_case_supplementaire(Ligne),
    writeln("TEST AFTER OK supplementaire "+Ligne + Colonne),
    Val is Ligne.

% Case chance
cyclist_eval((Ligne, Colonne), Cards, Val) :-
    writeln("TEST BEFORE "+Ligne + Colonne),
    case_chance(Ligne, Colonne),
    writeln("TEST AFTER OK Chance "+Ligne + Colonne),
    Val is Ligne - 3. % Exemple d'évaluation pour une "case chance"

% Ligne entre 89 et 102.
cyclist_eval((Ligne, _), _, Val) :- 
    Ligne >= 89,
    Ligne =< 102,
    Val is Ligne + 2.


/*************************/



/********* MOVE **********/
% move(State, ChildNode) : prend un état et renvoie un état enfant suivant les mouvements possibles
% State : l'état actuel du jeu
% ChildNode : état enfant généré en appliquant un mouvement possible à l'état actuel
%
%
%

/*************************/