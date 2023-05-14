% On appelle le fichier qui contient l'IA
% :- consult('bot.pl').

% On va tout d'abord faire le calcul de l'heuristique
% L'heuristique est une fonction qui estime la valeur d'un état donné du jeu.
% Dans ce code, la fonction de calcul de l'heuristique prend en entrée un état du jeu et renvoie une valeur numérique.

% Cas de base (victoire)
% Dans ce cas-ci, toutes les cartes ont été jouées et tous les joueurs sont passés -> 0
calcul_heuristic(etat(_, _, [], [], _, _),0).

% Cette clause correspond au cas où il reste des cartes à jouer dans le deck des joueurs et où il reste encore des coureurs sur la piste.
% Elle calcule l'heuristique de l'état en fonction de la valeur de la carte jouée et de l'équipe du coureur qui se déplace sur la piste.
calcul_heuristic(etat(Equipes, Cartes, Piste, [(A-_)-coureur(Equipe,_)|Cs], EquipeIndex, Deck),ValeurFinale):-7
    % Ici on va récupérer l'équipe courante à l'aide de son index
    nth0(EquipeIndex,Equipes,EquipeCourante),
    calcul_heuristic(etat(Equipes, Cartes, Piste, Cs, EquipeIndex, Deck),ValeurTmp),
    % Si l'équipe est l'équipe courante, on met à jour la valeur de l'heuristique avec la valeur de la carte jouée
    (Equipe = EquipeCourante ->
       ValeurFinale is ValeurTmp + A
       ;
    ValeurFinale = ValeurTmp
    ).

% Cette dernière clause s'applique si toutes les cartes ont été jouées, c'est-à-dire si la liste des cartes restantes est vide ([])
% et qu'il y a encore des coureurs sur la piste. Elle calcule la valeur heuristique en fonction de la position des coureurs sur la piste
% et de l'existence ou non d'une chute.
calcul_heuristic(etat(Equipes, Cartes, [(A-_)-coureur(Equipe,_,_,Chute)|Cs], [], EquipeIndex, Deck),ValeurFinale):-
    % Ici on va récupérer l'équipe courante à l'aide de son index
    nth0(EquipeIndex,Equipes,EquipeCourante),
    % On calcule l'heuristique pour les coureurs et les cartes restants
    calcul_heuristic(etat(Equipes, Cartes, Cs, [], EquipeIndex, Deck),ValeurTmp),
    % On fait comme pour la clause au-dessus en fonction de si l'équipe est l'équipe courante
    % Cependant on ajoute un malus de points si nous avons un phénomène de chute
    (Equipe = EquipeCourante ->
       ValeurTmp2 is ValeurTmp + A,
       % On check si on est dans le cas d'une chute, si oui on baisse la valeur de l'heuristique
       (Chute = true ->
        % Il faut tester des valeurs de 2 à 5 pour trouver la plus pertinente
          ValeurFinale is ValeurTmp2 - 2
          ;
          ValeurFinale = ValeurTmp2
       )
       ;
       ValeurFinale = ValeurTmp
    ).

% Passons maintenant à l'algo apha-beta
% Les clauses suivantes sont utilisées pour effectuer la recherche d'arbre de jeu en utilisant l'algorithme Alpha-Beta.

% Clause d'arrêt de la recherche
% Elle spécifie que lorsque la profondeur maximale Profondeur est atteinte,
% l'évaluation heuristique de la position actuelle doit être retournée en tant que valeur.
alpha_beta(_,0,(Position-_Action),_Alpha,_Beta,_NoMove,Value) :-
    calcul_heurist(Position,Value).
 
alpha_beta(EquipeMax,Profondeur,(etat(Equipes, Cartes, Plateau, Arrivee, EquipeIndex, Deck)-Act),Alpha,Beta,Move,Value) :- 
    % cette ligne vérifie que la profondeur de recherche est supérieure à 0. Si ce n'est pas le cas, 
    % on ne peut pas descendre plus bas dans l'arbre de recherche et on doit donc calculer l'heuristique de l'état courant.
    Profondeur > 0,
    % cette ligne génère la liste de tous les coups possibles pour l'équipe courante (EquipeMax) en utilisant la fonction perform
    % qui prend en entrée une action et un état de jeu et retourne l'état de jeu résultant. Les coups sont stockés dans une liste de tuples
    % (X-Action) où X est l'état résultant de l'action Action.
    findall((X-Action),perform(Action, etat(Equipes, Cartes, Plateau, Arrivee, EquipeIndex, Deck), X),Moves),
    % cette ligne trie les coups possibles en fonction de leur valeur, du plus grand au plus petit.
    % Le deuxième argument @> est une fonction qui détermine l'ordre de tri des tuples,
    % en triant selon le deuxième élément (la valeur) dans l'ordre décroissant.
    sort(2, @>, Moves, MovesSorted),
    %length(MovesSorted, NB), writeln(NB), printLists(MovesSorted), writeln(' '),
    % Ici on détermine la taille de la liste
    length(Equipes,N),
    % cette ligne est une condition qui vérifie si l'équipe courante est la dernière ou l'avant-dernière de la liste Equipes.
    ((0 is (EquipeMax mod N );0 is ((EquipeMax+1) mod N))  ->
    % Si c'est le cas, on effectue un "min-max" en inversant les bornes alpha et beta.
    %if
    Alpha1 is -Beta,% max/min
    Beta1 is -Alpha;
    %else
    Alpha1 is Alpha,
    Beta1 is Beta),
    % cette ligne diminue la profondeur de recherche (Profondeur) d'une unité si l'équipe courante est la dernière de la liste Equipes.
    (0 is ((EquipeMax+1) mod N) ->
    Profondeur1 is Profondeur-1;
    % Sinon, la profondeur reste inchangée.
    Profondeur1 is Profondeur
    ),
    % On incrémente l'index de l'équipe courante pour passer à la suivante
    EquipeMax1 is EquipeMax +1,
    evaluate_and_choose(EquipeMax1,MovesSorted,(etat(Equipes, Cartes, Plateau, Arrivee, EquipeIndex, Deck)-Act),Profondeur1,Alpha1,Beta1,nil,(Move,Value)).

% La clause suivante permet de choisir le meilleur coup à jouer en appelant alpha_beta() pour chaque coup possible, 
% en utilisant les valeurs d'Alpha et de Beta pour effectuer la coupe. Si alpha_beta/7 ne coupe pas la recherche,
% la fonction evaluate_and_choose/8 choisit le meilleur coup parmi ceux qui n'ont pas été coupés en appelant de nouveau evaluate_and_choose/8.
evaluate_and_choose(EquipeMax,[etat(Equipes, Cartes, Plateau, Arrivee, EquipeIndex, Deck)-Action|Moves],Position,Profondeur,Alpha,Beta,Record,BestMove) :-
    % On fait appel avec les paramètres EquipeMax, Profondeur, etat(Equipes, Cartes, Plateau, Arrivee, EquipeIndex, Deck)-Action, Alpha, et Beta. 
    % Cela retourne la valeur de Value, qui est l'estimation de la qualité du coup Action à partir de l'état etat(Equipes, Cartes, Plateau, Arrivee, EquipeIndex, Deck) selon l'algorithme alpha-beta.
    alpha_beta(EquipeMax,Profondeur,etat(Equipes, Cartes, Plateau, Arrivee, EquipeIndex, Deck)-Action,Alpha,Beta,_OtherMove,Value),
    % Calcul de la taille de la liste
    length(Equipes,N),
    % Ici on va maximiser le gain de l'équipe courante
    ((0 is (EquipeMax mod N );0 is ((EquipeMax+1) mod N))  ->
        %if
        Value1 is -Value
        ;
        %else
        Value1 is Value),
    % Cette fonction va vérifier si on a besoin de couper la recherche en checkant alpha et beta
    cutoff(EquipeMax,etat(Equipes, Cartes, Plateau, Arrivee, EquipeIndex, Deck)-Action,Value1,Profondeur,Alpha,Beta,Moves,Position,Record,BestMove).
% Ici c'est un cas de base qui est appelé lorsque la liste Moves est vide.
% Dans ce cas, BestMove est initialisé à (Move,Alpha), où Move est le coup précédemment considéré,
% et Alpha est la meilleure estimation de la qualité des coups trouvée jusqu'à présent.
evaluate_and_choose(_EquipeMax,[],_Position,_Profondeur,Alpha,_Beta,Move,(Move,Alpha)).

% Pour finir, la clause cutoff/10 effectue la coupe de l'arbre de recherche en fonction des valeurs d'Alpha et de Beta.
% Il y a trois cas à considérer :
% Si Value est supérieure ou égale à Beta, alors on coupe la recherche et on retourne le meilleur coup trouvé jusqu'à présent avec sa valeur.
cutoff(_EquipeMax,Move,Value,_Profondeur,_Alpha,Beta,_Moves,_Position,_Record,(Move,Value)) :- 
    Value >= Beta, !.
% Si Alpha < Value < Beta, alors on n'effectue pas la coupe, mais on continue la recherche en appelant evaluate_and_choose/8 pour les coups restants.
cutoff(EquipeMax,Move,Value,Profondeur,Alpha,Beta,Moves,Position,_Record,BestMove) :- 
    Alpha < Value, Value < Beta, !, 
    evaluate_and_choose(EquipeMax,Moves,Position,Profondeur,Value,Beta,Move,BestMove).
% Si Value est inférieure ou égale à Alpha, alors on coupe la recherche et on retourne le meilleur coup trouvé jusqu'à présent avec sa valeur.
cutoff(EquipeMax,_Move,Value,Profondeur,Alpha,Beta,Moves,Position,Record,BestMove) :- 
    Value =< Alpha, !, 
    evaluate_and_choose(EquipeMax,Moves,Position,Profondeur,Alpha,Beta,Record,BestMove).
