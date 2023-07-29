:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- consult('etat.pl').



start_maxmax(PlayerId, CyclistId,MaxCard),
    Depth is 3,
    stateInit(PlayerId, Coureurs, Cards, State),
    maxmax(State, BestNoeud, ValueNoeud, Depth),
    writeln("Valeur du meilleur coup "+ [ValueNoeud]),
    writeln("Noeud du meilleur coup "+ [BestNoeud]).
    %Chercher la carte jouer dans le BestNoeud


/******* WHO PLAY *******/

% Récupérer les états en début de partie 
% Pour chaque Player, tiré les cyclistes (plus loin au plus proche) % Stocker une liste
% Un compteur par cycliste 
% Porté 0 - 5 cartes = 5
% Porté 1 - 4 cartes = 20
% save cycliste ayant déjà jouer



% Prédicat pour obtenir l'état d'un joueur en fonction de son identifiant
stateBase(PlayerID, State) :-
    stateInit(PlayerID, _, _, State).


nextPlayer("Belgique", "Italie").
nextPlayer("Italie", "Hollande").
nextPlayer("Hollande", "Allemange").
nextPlayer("Allemagne", "Belgique").


whoCyclistePlay(State, CyclisteID) :-
    decompose(State, Pays, Cyclistes, Cards),
    decompose_coureurs(Cyclistes, Cycliste1, Cycliste2, Cycliste3),
    Cycliste1 = (Ligne1, _),
    Cycliste2 = (Ligne2, _),
    Cycliste3 = (Ligne3, _),
    smallest_line(Ligne1, Ligne2, Ligne3, MinLine),
    (
        (Cycliste1 = (MinLine, _) -> CyclisteID = 1);
        (Cycliste2 = (MinLine, _) -> CyclisteID = 2);
        (Cycliste3 = (MinLine, _) -> CyclisteID = 3)
    ),
    writeln("Plus petit cycliste "+CyclisteID).
    %set_cyclist_play(Pays, CyclisteID, 1).

finishPlayerPlay(State, NewState) :-
    decompose(State, Pays, Cyclistes, Cards),
    ( get_cyclist_play(Pays, 1, 1), get_cyclist_play(Pays, 2, 1) , get_cyclist_play(Pays, 3, 1) 
    ->  nextPlayer(Pays, NewPays),
        stateBase(NewPays, NewState)
    ; writeln("Peut encore jouer")
    ).

% Prédicat pour trouver la plus petite ligne parmi trois valeurs
smallest_line(L1, L2, L3, MinLine) :-
    MinLine is min(min(L1, L2), L3).

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
bestmove([], _, _, _, _).

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
    stateInit("Belgique", [Be1, Be2, Be3], Cards1, _),
    stateInit("Italie", [It1, It2, It3], Cards2, _),
    stateInit("Hollande", [Hol1, Hol2, Hol3], Cards3, _),
    stateInit("Allemagne", [All1, All2, All3], Cards4, _),
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
    whoCyclistePlay(State, CyclisteID),
    length(Cards, Longueur),
    (Depth > 0 
        -> 
        ;
    ),
    (Longueur = 5
        ->   move(State, Cards, Cards, CyclisteID, ChildNoeud1, CardsRestantes, Depth),
             move(State, CardsRestantes, Cards, CyclisteID, ChildNoeud2, CardsRestantes2, Depth),
             move(State, CardsRestantes2, Cards, CyclisteID, ChildNoeud3, CardsRestantes3, Depth),
             move(State, CardsRestantes3, Cards, CyclisteID, ChildNoeud4, CardsRestantes4, Depth),
             move(State, CardsRestantes4, Cards, CyclisteID, ChildNoeud5, CardsRestantes5, Depth),
             TmpChildNoeudList = [[ChildNoeud1], [ChildNoeud2], [ChildNoeud3], [ChildNoeud4], [ChildNoeud5]]
        ;   (Longueur = 4
                ->  move(State, Cards, Cards, CyclisteID, ChildNoeud1, CardsRestantes, Depth),
                    move(State, CardsRestantes, Cards, CyclisteID, ChildNoeud2, CardsRestantes2, Depth),
                    move(State, CardsRestantes2, Cards, CyclisteID, ChildNoeud3, CardsRestantes3, Depth),
                    move(State, CardsRestantes3, Cards, CyclisteID, ChildNoeud4, CardsRestantes4, Depth),
                    TmpChildNoeudList = [[ChildNoeud1], [ChildNoeud2], [ChildNoeud3], [ChildNoeud4]]
                ;   (Longueur = 3
                        ->  move(State, Cards, Cards, CyclisteID, ChildNoeud1, CardsRestantes, Depth),
                            move(State, CardsRestantes, Cards, CyclisteID, ChildNoeud2, CardsRestantes2, Depth),
                            move(State, CardsRestantes2, Cards, CyclisteID, ChildNoeud3, CardsRestantes3, Depth),
                            TmpChildNoeudList = [[ChildNoeud1], [ChildNoeud2], [ChildNoeud3]]
                        ;   (Longueur = 2
                                ->  move(State, Cards, Cards, CyclisteID, ChildNoeud1, CardsRestantes, Depth),
                                    move(State, CardsRestantes, Cards, CyclisteID, ChildNoeud2, _, Depth),
                                    TmpChildNoeudList = [[ChildNoeud1], [ChildNoeud2]]
                                ;   (Longueur = 1
                                        ->  move(State, Cards, Cards, CyclisteID, ChildNoeud1, _, Depth),
                                            TmpChildNoeudList = [[ChildNoeud1]]
                                        ;   writeln("KO")
                                    )
                            )
                    )
            )
    ),
    append(TmpChildNoeudList, ChildNoeudList).


move(State, CardsRestantes, Cards,CyclisteID, NewState, NewCardsRestantes, Depth) :- 
    take_card(CardsRestantes,Card),
    avancer_cycliste2(State,CardsRestantes, CyclisteID, Card, Cards, NewState, NewCardsRestantes).
    

take_card([Card | Cards], Card).
take_card([_,Cards], Card) :-
    take_card(Cards,Card).


get_player_cards(PlayerId, Cards).


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

