:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- consult('etat.pl').

/******* WHO PLAY *******/
maxPlayCount(3).

% Prédicat pour obtenir le prochain joueur
nextPlayer(Belgique, Italie).
nextPlayer(Italie,Hollande).
nextPlayer(Hollande,Allemange).
nextPlayer(Allemagne,Belgique).


% Save les etats de chaque joueur
% trouver le joueur qui doit jouer (envoyer via le serveur)
% chaque joueur peut jouer 3 fois
% si il n'a pas jouer on prend le cycliste le plus loin (petite ligne)
% si il a jouer une fois, on prend l'avant denier cycliste (moyenne ligne)
% si il a jouer 2 fois, on prend le premier cycliste (grosse ligne)
% si il a jouer 3 fois, on prend le joueur suivant


% Prédicat pour initialiser l'état du jeu
initGameState(StateB,StateI,StateH,StateA, State) :-
    State = [[StateB, 0],
    [StateI, 0],
    [StateH, 0],
    [StateA, 0]].


% Prédicat pour mettre à jour l'état du jeu après que le joueur ait joué un tour
updateGameState(Player, [Player, Coureurs, Cards, Counter], [Player, Coureurs, Cards, NewCounter]) :-
    NewCounter is Counter + 1.

% Prédicat pour obtenir le joueur qui doit jouer
getCurrentPlayer([[Player|_]|_], Player).

% Prédicat pour obtenir le cycliste suivant qui doit jouer en fonction du compteur de tours du joueur
getNextCyclist([_, [Cyclist|_], _, 0], Cyclist).
getNextCyclist([_, [_, Cyclist|_], _, 1], Cyclist).
getNextCyclist([_, [_, _, Cyclist|_], _, 2], Cyclist).
getNextCyclist([_, [_, _, _, Cyclist|_], _, 3], Cyclist).

% Prédicat pour réinitialiser le compteur de tours d'un joueur à 0
resetCounter([Player, Coureurs, Cards, _], [Player, Coureurs, Cards, 0]).

/***********************/

/******* MAX MAX *******/
% State : Etat
% BestNoeud : Meilleur noeud 
% ValueNoeud : Valeur noeud actuel
% Depth : profondeur


maxmax(State, BestNoeud, ValueNoeud, Depth) :-
    Depth > 0,
    move(State, ChildNoeudList, Depth),
    NewDepth is Depth - 1,
    bestmove(ChildNoeudList, BestNoeud, ValueNoeud, NewDepth), !
    ;
    evaluate([_,_,_,_,State], ValueNoeud).

/***********************/



/******* BEST MOVE *******/
bestmove([], _, _, _).

bestmove([Node], Node, ValueNoeud, Depth) :-
    maxmax(Node, _, ValueNoeud, Depth), !. 

bestmove([ChildNoeud | ChildNoeudList], BestNoeud, BestValue, Depth) :-
    maxmax(ChildNoeud, _, ValuePremierNoeud, Depth),
    bestmove(ChildNoeudList, SecondNoeud, ValueSecondNoeud, Depth),
    betterof(ChildNoeud, ValuePremierNoeud, SecondNoeud, ValueSecondNoeud, BestNoeud, BestValue).


/**************************/


/******* BETTER OF *******/
betterof(PremierNoeud, ValuePremierNoeud, SecondNoeud, ValueSecondNoeud, PremierNoeud, ValuePremierNoeud) :-
   % writeln("TEST BETTEROF PremierNoeud " + PremierNoeud),
   % writeln("TEST BETTEROF ValuePremierNoeud " + ValuePremierNoeud),
   % writeln("TEST BETTEROF SecondNoeud " + SecondNoeud),
   % writeln("TEST BETTEROF ValueSecondNoeud " + ValueSecondNoeud),
    sum_list(ValuePremierNoeud, SumPremierNoeud),
    sum_list(ValueSecondNoeud, SumSecondNoeud),
  % writeln("SumPremierNoeud " + SumPremierNoeud),
  % writeln("SumSecondNoeud " + SumSecondNoeud),
    SumPremierNoeud > SumSecondNoeud.

betterof(_, _, SecondNoeud, ValueSecondNoeud, SecondNoeud, ValueSecondNoeud).


/*************************/



/******* EVALUATE *******/
% evaluate(State, Value) : renvoie la valeur d'un état donné suivant une heuristique
% State : l'état actuel du jeu
% Value : [Val1, Val2, Val3, Val4]
%
% Chute : val - 20                          OK
% Case chance : Val - 3                     OK
% Ligne arrivé (102) : Val + 20             OK
% Case supplémentaire (103 - 112): Val      OK
% Case vierge : Val                         OK      
% Case 89 - 102 : Val + 2                   OK

% Décomposition de PlayerCurrent
decompose(PlayerCurrent, Pays, Coureurs, Cartes) :-
    PlayerCurrent = [Pays, Coureurs, Cartes].

% Décomposition de la liste des coureurs
decompose_coureurs([], [], [], []).
decompose_coureurs([(A, B) | Reste], Coureur1, Coureur2, Coureur3) :-
    Coureur1 = (A, B),
    decompose_coureurs(Reste, Coureur2, Coureur3, []).


evaluate([Belgique, Italie, Hollande, Allemagne, PlayerCurrent], [Val1, Val2, Val3, Val4]) :-
    stateInit("Belgique", [Be1, Be2, Be3], Cards1),
    stateInit("Italie", [It1, It2, It3], Cards2),
    stateInit("Hollande", [Hol1, Hol2, Hol3], Cards3),
    stateInit("Allemagne", [All1, All2, All3], Cards4),
    decompose(PlayerCurrent, Pays, Coureurs, Cards),
    decompose_coureurs(Coureurs, Coureur1, Coureur2, Coureur3),
    (Pays = "Belgique"
        -> player_eval([Coureur1, Coureur2, Coureur3], Cards, Val1),
            player_eval([It1, It2, It3], Cards2, Val2),
            player_eval([Hol1, Hol2, Hol3], Cards3, Val3),
            player_eval([All1, All2, All3], Cards4, Val4)
            ; write("")
    ),
    (Pays = "Italie"
        -> player_eval([Be1, Be2, Be3], Cards1, Val1),
            player_eval([Coureur1, Coureur2, Coureur3], Cards, Val2),
            player_eval([Hol1, Hol2, Hol3], Cards3, Val3),
            player_eval([All1, All2, All3], Cards4, Val4)
            ; write("")
    ),
    (Pays = "Hollande"
        -> player_eval([Be1, Be2, Be3], Cards1, Val1),
            player_eval([It1, It2, It3], Cards2, Val2),
            player_eval([Coureur1, Coureur2, Coureur3], Cards, Val3),
            player_eval([All1, All2, All3], Cards4, Val4)
            ; write("")
    ),
    (Pays = "Allemagne"
        -> player_eval([Be1, Be2, Be3], Cards1, Val1),
            player_eval([It1, It2, It3], Cards2, Val2),
            player_eval([Hol1, Hol2, Hol3], Cards3, Val3),
            player_eval([Coureur1, Coureur2, Coureur3], Cards, Val4)
            ; write("")
    ).



  
player_eval([Coureur1, Coureur2, Coureur3], Cards, Val):-
    cyclist_eval(Coureur1, Cards, Val1),
    cyclist_eval(Coureur2, Cards, Val2),
    cyclist_eval(Coureur3, Cards, Val3),
   
    Val is Val1 + Val2 + Val3.


% Exclure les lignes comprises entre 89 et 102
exclude_lines(Ligne) :- Ligne >= 89, Ligne =< 102.


% Ligne 102
cyclist_eval((102, Colonne), Cards, Val) :- 
    Val is 102 + 20.

% Case supplémentaire
cyclist_eval((Ligne, Colonne), Cards, Val) :- 
    is_case_supplementaire(Ligne),
    Val is Ligne.

% Case chance
cyclist_eval((Ligne, Colonne), Cards, Val) :-
    case_chance(Ligne, Colonne),
    Val is Ligne - 3. % Exemple d'évaluation pour une "case chance"

% Ligne entre 89 et 102.
cyclist_eval((Ligne, _), _, Val) :- 
    Ligne >= 89,
    Ligne =< 102,
    Val is Ligne + 2.

% Chute
cyclist_eval((Ligne, Colonne), Cards, Val) :- 
    \+ case_disponible_et_presente(Ligne),
    Val is Ligne -20.
    
    
% Global 
cyclist_eval((Ligne, Colonne), Cards, Val) :-
    \+ case_chance(Ligne, Colonne), 
    \+ is_case_supplementaire(Ligne), 
    \+ exclude_lines(Ligne), 
    case_disponible_et_presente(Ligne), 
    Ligne =\= 102, 
    Val is Ligne. 


/*************************/


/********* MOVE **********/
% Nouvelle save des cards restantes
% Choix cycliste
% Choix State
% Edit move afin de faire une boucle en fonction du nombre de cards

%Les cartes restantes à tester      : CardsRestantes
%Les cartes jouer 	                : CardPlay
%Le deck complet		            : Cards
%Les cartes qui n'ont pas été jouer : CardsDontPlay

move(State, ChildNoeudList, Depth) :- 
    decompose(State, Pays, Coureurs, Cards),
    length(Cards, Longueur),
    (Longueur = 5
        ->   move(State, Cards, Cards, ChildNoeud1, CardsRestantes, Depth),
             move(State, CardsRestantes, Cards, ChildNoeud2, CardsRestantes2, Depth),
             move(State, CardsRestantes2, Cards, ChildNoeud3, CardsRestantes3, Depth),
             move(State, CardsRestantes3, Cards, ChildNoeud4, CardsRestantes4, Depth),
             move(State, CardsRestantes4, Cards, ChildNoeud5, CardsRestantes5, Depth),
             TmpChildNoeudList = [[ChildNoeud1], [ChildNoeud2], [ChildNoeud3], [ChildNoeud4], [ChildNoeud5]]
        ;   (Longueur = 4
                ->  move(State, Cards, Cards, ChildNoeud1, CardsRestantes, Depth),
                    move(State, CardsRestantes, Cards, ChildNoeud2, CardsRestantes2, Depth),
                    move(State, CardsRestantes2, Cards, ChildNoeud3, CardsRestantes3, Depth),
                    move(State, CardsRestantes3, Cards, ChildNoeud4, CardsRestantes4, Depth),
                    TmpChildNoeudList = [[ChildNoeud1], [ChildNoeud2], [ChildNoeud3], [ChildNoeud4]]
                ;   (Longueur = 3
                        ->  move(State, Cards, Cards, ChildNoeud1, CardsRestantes, Depth),
                            move(State, CardsRestantes, Cards, ChildNoeud2, CardsRestantes2, Depth),
                            move(State, CardsRestantes2, Cards, ChildNoeud3, CardsRestantes3, Depth),
                            TmpChildNoeudList = [[ChildNoeud1], [ChildNoeud2], [ChildNoeud3]]
                        ;   (Longueur = 2
                                ->  move(State, Cards, Cards, ChildNoeud1, CardsRestantes, Depth),
                                    move(State, CardsRestantes, Cards, ChildNoeud2, _, Depth),
                                    TmpChildNoeudList = [[ChildNoeud1], [ChildNoeud2]]
                                ;   (Longueur = 1
                                        ->  move(State, Cards, Cards, ChildNoeud1, _, Depth),
                                            TmpChildNoeudList = [[ChildNoeud1]]
                                        ;   writeln("KO")
                                    )
                            )
                    )
            )
    ),
    append(TmpChildNoeudList, ChildNoeudList).


/*
% Prédicat pour effectuer le mouvement pour chaque profondeur
move(State, CardsRestantes, Cards, NewState, NewCardsRestantes, Depth) :- 
    Depth = 3,
    take_card(CardsRestantes, Card),
    avancer_cycliste2(State, CardsRestantes, 1, Card, Cards, NewState, NewCardsRestantes).

move(State, CardsRestantes, Cards, NewState, NewCardsRestantes, Depth) :- 
    Depth = 2,
    take_card(CardsRestantes, Card),
    avancer_cycliste2(State, CardsRestantes, 2, Card, Cards, NewState, NewCardsRestantes).

move(State, CardsRestantes, Cards, NewState, NewCardsRestantes, Depth) :- 
    Depth = 1,
    take_card(CardsRestantes, Card),
    avancer_cycliste2(State, CardsRestantes, 3, Card, Cards, NewState, NewCardsRestantes).
*/

move(State, CardsRestantes, Cards, NewState, NewCardsRestantes, Depth) :- 
    take_card(CardsRestantes,Card),
    avancer_cycliste2(State,CardsRestantes, 1, Card, Cards, NewState, NewCardsRestantes).
    

take_card([Card | Cards], Card).
take_card([_,Cards], Card) :-
    take_card(Cards,Card).


get_player_cards(PlayerId, Cards).

/*
avancer_cycliste2(State,CardsRestantes, SelectedCyclist, Card, Cards, NewState, NewCardsRestantes) :-
    get_cyclist_position(State, SelectedCyclist, LigneAvant, ColonneAvant),
    NewLigne is LigneAvant + Card,
    NewColonne is 1,
    \+ is_case_supplementaire(NewLigne),
    remove_first_elem(CardsRestantes, NewCardsRestantes),
    remove_card2(Card, Cards, CardsDontPlay),
    get_cyclist_position(State, 1, NewLigne1, NewColonne1),
    get_cyclist_position(State, 2, NewLigne2, NewColonne2),
    get_cyclist_position(State, 3, NewLigne3, NewColonne3),
    NewState = [State, [(NewLigne, NewColonne), (NewLigne2, NewColonne2), (NewLigne3, NewColonne3)], CardsDontPlay],
    writeln("NewState "+NewState).
*/

avancer_cycliste2(State,CardsRestantes, SelectedCyclist, Card, Cards, NewState, NewCardsRestantes) :-
    decompose(State, Pays, Coureurs, Cards),
    decompose_coureurs(Coureurs, Coureur1, Coureur2, Coureur3),
    (SelectedCyclist = 1
        -> Coureur1 = (LigneAvant, Colonne),
           NewLigne is LigneAvant + Card,
           NewColonne is 1,
           \+ is_case_supplementaire(NewLigne),
           remove_first_elem(CardsRestantes, NewCardsRestantes),
           remove_card2(Card, Cards, CardsDontPlay),
           NewState = [Pays, [(NewLigne, NewColonne),Coureur2, Coureur3], CardsDontPlay]
        ; (SelectedCyclist = 2
            ->  Coureur2 = (LigneAvant, Colonne),
                NewLigne is LigneAvant + Card,
                NewColonne is 1,
                \+ is_case_supplementaire(NewLigne),
                remove_first_elem(CardsRestantes, NewCardsRestantes),
                remove_card2(Card, Cards, CardsDontPlay),
                NewState = [Pays, [Coureur1,(NewLigne, NewColonne), Coureur3], CardsDontPlay] 
            ; (SelectedCyclist = 3
                ->  Coureur3 = (LigneAvant, Colonne),
                    NewLigne is LigneAvant + Card,
                    NewColonne is 1,
                    \+ is_case_supplementaire(NewLigne),
                    remove_first_elem(CardsRestantes, NewCardsRestantes),
                    remove_card2(Card, Cards, CardsDontPlay),
                    NewState = [Pays, [Coureur1,Coureur2, (NewLigne, NewColonne)], CardsDontPlay] 
                ; writeln("KO")
                )
            )
    ),
    writeln("NewState "+NewState).

/*
% Cas lorsque SelectedCyclist = 1
avancer_cycliste2(State, CardsRestantes, 1, Card, Cards, NewState, NewCardsRestantes) :-
    decompose(State, Pays, Coureurs, Cards),
    decompose_coureurs(Coureurs, Coureur1, Coureur2, Coureur3),
    Coureur1 = (LigneAvant, Colonne),
    NewLigne is LigneAvant + Card,
    NewColonne is 1,
    \+ is_case_supplementaire(NewLigne),
    remove_first_elem(CardsRestantes, NewCardsRestantes),
    remove_card2(Card, Cards, CardsDontPlay),
    NewState = [Pays, [(NewLigne, NewColonne), Coureur2, Coureur3], CardsDontPlay],
    writeln("NewState " + NewState).

% Cas lorsque SelectedCyclist = 2
avancer_cycliste2(State, CardsRestantes, 2, Card, Cards, NewState, NewCardsRestantes) :-
    decompose(State, Pays, Coureurs, Cards),
    decompose_coureurs(Coureurs, Coureur1, Coureur2, Coureur3),
    Coureur2 = (LigneAvant, Colonne),
    NewLigne is LigneAvant + Card,
    NewColonne is 1,
    \+ is_case_supplementaire(NewLigne),
    remove_first_elem(CardsRestantes, NewCardsRestantes),
    remove_card2(Card, Cards, CardsDontPlay),
    NewState = [Pays, [Coureur1, (NewLigne, NewColonne), Coureur3], CardsDontPlay],
    writeln("NewState " + NewState).

% Cas lorsque SelectedCyclist = 3
avancer_cycliste2(State, CardsRestantes, 3, Card, Cards, NewState, NewCardsRestantes) :-
    decompose(State, Pays, Coureurs, Cards),
    decompose_coureurs(Coureurs, Coureur1, Coureur2, Coureur3),
    Coureur3 = (LigneAvant, Colonne),
    NewLigne is LigneAvant + Card,
    NewColonne is 1,
    \+ is_case_supplementaire(NewLigne),
    remove_first_elem(CardsRestantes, NewCardsRestantes),
    remove_card2(Card, Cards, CardsDontPlay),
    NewState = [Pays, [Coureur1, Coureur2, (NewLigne, NewColonne)], CardsDontPlay],
    writeln("NewState " + NewState).
*/

remove_first_elem([_|Rest], Rest).


% Prédicat pour retirer une carte d'une liste de cartes
remove_card2(Card, Cards, NewCards) :-
    select(Card, Cards, NewCards).

/*************************/

/********* MOVE **********/

/*
    move(State, ChildNoeud, Depth) :- 
        get_player_cards(State, Cards),
        move(State, Cards, ChildNoeud, _, Depth),
        writeln("ChildNoeud "+ChildNoeud).

    take_card([Card | Cards], Card).
    take_card([_,Cards], Card) :-
        take_card(Cards,Card).


    get_player_cards(PlayerId, Cards).


    get_cyclists_list(State, CyclistsList) :-
        get_cyclist_position(State, 1, Ligne1, Colonne1),
        get_cyclist_position(State, 2, Ligne2, Colonne2),
        get_cyclist_position(State, 3, Ligne3, Colonne3),
        CyclistsList = [(1,Ligne1, Colonne1), (2,Ligne2, Colonne2), (3,Ligne3, Colonne3)].

    % Prédicat pour sélectionner le coureur avec la ligne la plus petite dans la liste CyclistsList
    select_cyclist_with_smallest_line(CyclistsList, SelectedCyclist) :-
        get_lines(CyclistsList, Lines),
        min_list(Lines, MinLine),
        get_cyclist_position(State, SelectedCyclist, MinLine, _).


    % Prédicat pour extraire les lignes de la liste des coureurs
    get_lines([], []).
    get_lines([(_,Line, _) | Rest], [Line | LinesRest]) :-
        get_lines(Rest, LinesRest).



    move(State, Cards, NewState, NewCards, Depth) :- 
        writeln("State  "+State),
        take_card(Cards,Card),
        get_cyclists_list(State, CyclistsList),
        writeln("CyclistsList "+CyclistsList),
        select_cyclist_with_smallest_line(CyclistsList, SelectedCyclist),
        writeln("SelectedCyclist "+SelectedCyclist),
        avancer_cycliste2(State,Cards, SelectedCyclist, Card, NewState, NewCards).

    avancer_cycliste2(State,Cards, SelectedCyclist, Card, NewState, NewCards) :-
        get_cyclist_position(State, SelectedCyclist, LigneAvant, ColonneAvant),
        NewLigne is LigneAvant + Card,
        NewColonne is 1,
        \+ is_case_supplementaire(NewLigne),
        set_cyclist_position(State, SelectedCyclist, NewLigne, NewColonne),
        remove_card2(Card, Cards, NewCards),
        % Mettre à jour le nouvel état en fonction des nouveaux coureurs et cartes
        get_cyclist_position(State, 1, NewLigne1, NewColonne1),
        get_cyclist_position(State, 2, NewLigne2, NewColonne2),
        get_cyclist_position(State, 3, NewLigne3, NewColonne3),
        NewState = [State, [(NewLigne1, NewColonne1), (NewLigne2, NewColonne2), (NewLigne3, NewColonne3)], NewCards],
        writeln("NewState "+NewState).


    % Prédicat pour retirer une carte d'une liste de cartes
    remove_card2(Card, [Card|Rest], Rest).
    remove_card2(Card, [X|Rest], [X|NewRest]) :-
        remove_card(Card, Rest, NewRest).
    */
/*************************/