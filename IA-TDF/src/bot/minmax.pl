:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- consult('etat.pl').

/******* START MAXMA *******/

start_maxmax(PlayerId, CyclistId, MaxCard) :-
    writeln("STARTING MAXMAX"),
    Depth is 12,
    set_cyclist_depth(PlayerId, CyclistId, Depth),
    set_cyclist_play_tmp(PlayerId, CyclistId, 1),
    stateInit(PlayerId, Coureurs, Cards, StateForLoop),
    run_depth_loop(StateForLoop, Depth),
    stateInit("Belgique", _, _, StateBE),
    stateInit("Italie", _, _, StateIT),
    stateInit("Hollande", _, _, StateHO),
    stateInit("Allemagne", _, _, StateAL),
    States = [StateBE, StateIT, StateHO, StateAL, PlayerId],
    maxmax(States, BestNoeud, ValueNoeud, Depth),
    writeln("Valeur du meilleur coup "+ [ValueNoeud]),
    writeln("Noeud du meilleur coup "+ [BestNoeud]).

% Prédicat pour exécuter la boucle jusqu'à ce que TempDepth atteigne 0
run_depth_loop(State, Depth) :-
    Depth > 0,
    TempDepth is Depth - 1,
    whoCyclistePlay(State, TempDepth),
    run_depth_loop(State, TempDepth).
run_depth_loop(_, _).


/************************/



/******* WHO PLAY *******/



% Prédicat pour obtenir l'état d'un joueur en fonction de son identifiant
stateBase(PlayerID, State) :-
    stateInit(PlayerID, _, _, State).


nextPlayer("Belgique", "Italie").
nextPlayer("Italie", "Hollande").
nextPlayer("Hollande", "Allemange").
nextPlayer("Allemagne", "Belgique").


% Le prédicat de base qui associe les cyclistes avec un Depths
whoCyclistePlay(State, Depth) :-
    decompose(State, Pays, Cyclistes, Cards),
    decompose_coureurs(Cyclistes, Cycliste1, Cycliste2, Cycliste3),
    Cycliste1 = (Ligne1, _),
    Cycliste2 = (Ligne2, _),
    Cycliste3 = (Ligne3, _),
    smallest_line(Pays,Ligne1, Ligne2, Ligne3, MinLine),
    (
        (get_cyclist_play(Pays, 1, Bool1), Bool1 = 0, get_cyclist_play_tmp(Pays, 1, 0), Cycliste1 = (MinLine, _) -> CyclisteID = 1, set_cyclist_depth(Pays, 1, Depth), set_cyclist_play_tmp(Pays, 1, 1), NewDepth is Depth - 1);
        (get_cyclist_play(Pays, 2, Bool2), Bool2 = 0, get_cyclist_play_tmp(Pays, 2, 0), Cycliste2 = (MinLine, _) -> CyclisteID = 2, set_cyclist_depth(Pays, 2, Depth), set_cyclist_play_tmp(Pays, 2, 1), NewDepth is Depth - 1);
        (get_cyclist_play(Pays, 3, Bool3), Bool3 = 0, get_cyclist_play_tmp(Pays, 3, 0), Cycliste3 = (MinLine, _) -> CyclisteID = 3, set_cyclist_depth(Pays, 3, Depth), set_cyclist_play_tmp(Pays, 3, 1), NewDepth is Depth - 1);
        (nextPlayer(Pays, NewPays), stateBase(NewPays, NewState), whoCyclistePlay(NewState, Depth)) % Si tous les cyclistes ont joué, passez au joueur suivant avec le même Depth
    ).


% Prédicat pour trouver la plus petite ligne parmi trois valeurs
smallest_line(Pays,L1, L2, L3, MinLine) :-
    (get_cyclist_play_tmp(Pays, 1, 1) -> NewL1 is 9999; NewL1 is L1),
    (get_cyclist_play_tmp(Pays, 2, 1) -> NewL2 is 9999; NewL2 is L2),
    (get_cyclist_play_tmp(Pays, 3, 1) -> NewL3 is 9999; NewL3 is L3),
    MinLine is min(min(NewL1, NewL2), NewL3).


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
    evaluate(State, ValueNoeud).


/***********************/



/******* BEST MOVE *******/
bestmove([], _, _, _, _).

bestmove([Node], Node, ValueNoeud, Depth) :-
    maxmax(Node, _, ValueNoeud, Depth), !. 
/*
bestmove([ChildNoeud | ChildNoeudList], BestNoeud, BestValue, Depth) :-
    maxmax(ChildNoeud, _, ValuePremierNoeud, Depth),
    bestmove(ChildNoeudList, SecondNoeud, ValueSecondNoeud, Depth),
    betterof(ChildNoeud, ValuePremierNoeud, SecondNoeud, ValueSecondNoeud, BestNoeud, BestValue).
*/
bestmove([ChildNoeud | ChildNoeudList], BestNoeud, BestValue, Depth) :-
    maxmax(ChildNoeud, _, ValuePremierNoeud, Depth),
    bestmove(ChildNoeudList, SecondNoeud, ValueSecondNoeud, Depth),
    betterof(FirstFiveElements, ValuePremierNoeud, SecondNoeud, ValueSecondNoeud, BestNoeud, BestValue).


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

% Décomposition de State
decompose_state(State, StateBE, StateIT, StateHO, StateAL, PlayerID) :-
    State = [StateBE, StateIT, StateHO, StateAL, PlayerID].

compose_state(State, StateBE, StateIT, StateHO, StateAL, PlayerID) :-
    State = [StateBE, StateIT, StateHO, StateAL, PlayerID].

% Décomposition de la liste des coureurs
decompose_coureurs([], [], [], []).
decompose_coureurs([(A, B) | Reste], Coureur1, Coureur2, Coureur3) :-
    Coureur1 = (A, B),
    decompose_coureurs(Reste, Coureur2, Coureur3, []).


evaluate([Belgique, Italie, Hollande, Allemagne, PlayerCurrent], [Val1, Val2, Val3, Val4]) :-
    %stateInit("Belgique", [Be1, Be2, Be3], Cards1, _),
    %stateInit("Italie", [It1, It2, It3], Cards2, _),
    %stateInit("Hollande", [Hol1, Hol2, Hol3], Cards3, _),
    %stateInit("Allemagne", [All1, All2, All3], Cards4, _),
    decompose(Belgique, _ , CoureursBE, Cards1),
    decompose_coureurs(CoureursBE, Be1, Be2, Be3),
    player_eval([Be1, Be2, Be3], Cards1, Val1),

    decompose(Italie, _ , CoureursIT, Cards2),
    decompose_coureurs(CoureursIT, It1, It2, It3),
    player_eval([It1, It2, It3], Cards2, Val2),

    decompose(Hollande, _ , CoureursHO, Cards3),
    decompose_coureurs(CoureursHO, Hol1, Hol2, Hol3),
    player_eval([Hol1, Hol2, Hol3], Cards3, Val3),

    decompose(Allemagne, _ , CoureursAL, Cards4),
    decompose_coureurs(CoureursAL, All1, All2, All3),
    player_eval([All1, All2, All3], Cards4, Val4).

/*
    decompose(PlayerCurrent, Pays, Coureurs, Cards),
    decompose_coureurs(Coureurs, Coureur1, Coureur2, Coureur3),
    (Pays = "Belgique"
        ->  player_eval([Coureur1, Coureur2, Coureur3], Cards, Val1),
            player_eval([It1, It2, It3], Cards2, Val2),
            player_eval([Hol1, Hol2, Hol3], Cards3, Val3),
            player_eval([All1, All2, All3], Cards4, Val4)
            ; write("")
    ),
    (Pays = "Italie"
        ->  player_eval([Be1, Be2, Be3], Cards1, Val1),
            player_eval([Coureur1, Coureur2, Coureur3], Cards, Val2),
            player_eval([Hol1, Hol2, Hol3], Cards3, Val3),
            player_eval([All1, All2, All3], Cards4, Val4)
            ; write("")
    ),
    (Pays = "Hollande"
        ->  player_eval([Be1, Be2, Be3], Cards1, Val1),
            player_eval([It1, It2, It3], Cards2, Val2),
            player_eval([Coureur1, Coureur2, Coureur3], Cards, Val3),
            player_eval([All1, All2, All3], Cards4, Val4)
            ; write("")
    ),
    (Pays = "Allemagne"
        ->  player_eval([Be1, Be2, Be3], Cards1, Val1),
            player_eval([It1, It2, It3], Cards2, Val2),
            player_eval([Hol1, Hol2, Hol3], Cards3, Val3),
            player_eval([Coureur1, Coureur2, Coureur3], Cards, Val4)
            ; write("")
    ).
*/


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

move(States, ChildNoeudList, Depth) :-
    decompose_state(States, StateBE, StateIT, StateHO, StateAL, Player),
    get_cyclist_depth(PlayerID, CyclisteID, Depth),
    writeln("Player "+Player+ "CyclisteID "+ CyclisteID+ " Depth "+ Depth),
    (PlayerID = "Belgique"
        -> decompose(StateBE, Pays, Coureurs, Cards), State = StateBE
        ; write("")
    ),
    (PlayerID = "Italie"
        -> decompose(StateIT, Pays, Coureurs, Cards), State = StateIT
        ; write("")
    ),
    (PlayerID = "Hollande"
        -> decompose(StateHO, Pays, Coureurs, Cards), State = StateHO
        ; write("")
    ),
    (PlayerID = "Allemange"
        -> decompose(StateAL, Pays, Coureurs, Cards), State = StateAL
        ; write("")
    ),
    length(Cards, Longueur),
    (Longueur = 5
        ->   move(State, Cards, Cards, CyclisteID, ChildNoeud1, CardsRestantes, Depth),
             move(State, CardsRestantes, Cards, CyclisteID, ChildNoeud2, CardsRestantes2, Depth),
             move(State, CardsRestantes2, Cards, CyclisteID, ChildNoeud3, CardsRestantes3, Depth),
             move(State, CardsRestantes3, Cards, CyclisteID, ChildNoeud4, CardsRestantes4, Depth),
             move(State, CardsRestantes4, Cards, CyclisteID, ChildNoeud5, CardsRestantes5, Depth),
             (PlayerID = "Belgique"
                -> TmpChildNoeudList = [[[ChildNoeud1, StateIT, StateHO, StateAL, PlayerID], [ChildNoeud2, StateIT, StateHO, StateAL, PlayerID], [ChildNoeud3, StateIT, StateHO, StateAL, PlayerID], [ChildNoeud4, StateIT, StateHO, StateAL, PlayerID], [ChildNoeud5, StateIT, StateHO, StateAL, PlayerID]]]
                ; write("")
            ),
            (PlayerID = "Italie"
                -> TmpChildNoeudList = [[[StateBE, ChildNoeud1, StateHO, StateAL, PlayerID], [StateBE, ChildNoeud2, StateHO, StateAL, PlayerID], [StateBE, ChildNoeud3, StateHO, StateAL, PlayerID], [StateBE, ChildNoeud4, StateHO, StateAL, PlayerID], [StateBE, ChildNoeud5, StateHO, StateAL, PlayerID]]]
                ; write("")
            ),
            (PlayerID = "Hollande"
                -> TmpChildNoeudList = [[[StateBE, StateIT,ChildNoeud1, StateAL , PlayerID], [StateBE, StateIT,ChildNoeud2, StateAL , PlayerID], [StateBE, StateIT,ChildNoeud3, StateAL , PlayerID], [StateBE, StateIT,ChildNoeud4, StateAL , PlayerID], [StateBE, StateIT,ChildNoeud5, StateAL , PlayerID]]]
                ; write("")
            ),
            (PlayerID = "Allemange"
                -> TmpChildNoeudList = [[[StateBE, StateIT, StateHO, ChildNoeud1 , PlayerID], [StateBE, StateIT,StateHO, ChildNoeud2, PlayerID], [StateBE, StateIT,StateHO, ChildNoeud3 , PlayerID], [StateBE, StateIT,StateHO, ChildNoeud4 , PlayerID], [StateBE, StateIT,StateHO, ChildNoeud5, PlayerID]]]
                ; write("")
            ), append(TmpChildNoeudList, ChildNoeudList), !
        ;   (Longueur = 4
                ->  move(State, Cards, Cards, CyclisteID, ChildNoeud1, CardsRestantes, Depth),
                    move(State, CardsRestantes, Cards, CyclisteID, ChildNoeud2, CardsRestantes2, Depth),
                    move(State, CardsRestantes2, Cards, CyclisteID, ChildNoeud3, CardsRestantes3, Depth),
                    move(State, CardsRestantes3, Cards, CyclisteID, ChildNoeud4, CardsRestantes4, Depth),
                    writeln("TEST"),
                    (PlayerID = "Belgique"
                        -> TmpChildNoeudList = [[[ChildNoeud1, StateIT, StateHO, StateAL, PlayerID], [ChildNoeud2, StateIT, StateHO, StateAL, PlayerID], [ChildNoeud3, StateIT, StateHO, StateAL, PlayerID], [ChildNoeud4, StateIT, StateHO, StateAL, PlayerID]]]
                        ; write("")
                    ),
                    (PlayerID = "Italie"
                        -> TmpChildNoeudList = [[[StateBE, ChildNoeud1, StateHO, StateAL, PlayerID], [StateBE, ChildNoeud2, StateHO, StateAL, PlayerID], [StateBE, ChildNoeud3, StateHO, StateAL, PlayerID], [StateBE, ChildNoeud4, StateHO, StateAL, PlayerID]]]
                        ; write("")
                    ),
                    (PlayerID = "Hollande"
                        -> TmpChildNoeudList = [[[StateBE, StateIT,ChildNoeud1, StateAL , PlayerID], [StateBE, StateIT,ChildNoeud2, StateAL , PlayerID], [StateBE, StateIT,ChildNoeud3, StateAL , PlayerID], [StateBE, StateIT,ChildNoeud4, StateAL , PlayerID]]]
                        ; write("")
                    ),
                    (PlayerID = "Allemange"
                        -> TmpChildNoeudList = [[[StateBE, StateIT, StateHO, ChildNoeud1 , PlayerID], [StateBE, StateIT,StateHO, ChildNoeud2, PlayerID], [StateBE, StateIT,StateHO, ChildNoeud3 , PlayerID], [StateBE, StateIT,StateHO, ChildNoeud4 , PlayerID]]]
                        ; write("")
                    ), append(TmpChildNoeudList, ChildNoeudList), !
                ;   (Longueur = 3
                        ->  move(State, Cards, Cards, CyclisteID, ChildNoeud1, CardsRestantes, Depth),
                            move(State, CardsRestantes, Cards, CyclisteID, ChildNoeud2, CardsRestantes2, Depth),
                            move(State, CardsRestantes2, Cards, CyclisteID, ChildNoeud3, CardsRestantes3, Depth),
                            (PlayerID = "Belgique"
                                -> TmpChildNoeudList = [[[ChildNoeud1, StateIT, StateHO, StateAL, PlayerID], [ChildNoeud2, StateIT, StateHO, StateAL, PlayerID], [ChildNoeud3, StateIT, StateHO, StateAL, PlayerID]]]
                                ; write("")
                            ),
                            (PlayerID = "Italie"
                                -> TmpChildNoeudList = [[[StateBE, ChildNoeud1, StateHO, StateAL, PlayerID], [StateBE, ChildNoeud2, StateHO, StateAL, PlayerID], [StateBE, ChildNoeud3, StateHO, StateAL, PlayerID]]]
                                ; write("")
                            ),
                            (PlayerID = "Hollande"
                                -> TmpChildNoeudList = [[[StateBE, StateIT,ChildNoeud1, StateAL , PlayerID], [StateBE, StateIT,ChildNoeud2, StateAL , PlayerID], [StateBE, StateIT,ChildNoeud3, StateAL , PlayerID]]]
                                ; write("")
                            ),
                            (PlayerID = "Allemange"
                                -> TmpChildNoeudList = [[[StateBE, StateIT, StateHO, ChildNoeud1 , PlayerID], [StateBE, StateIT,StateHO, ChildNoeud2, PlayerID], [StateBE, StateIT,StateHO, ChildNoeud3 , PlayerID]]]
                                ; write("")
                            ), append(TmpChildNoeudList, ChildNoeudList), !
                        ;   (Longueur = 2
                                ->  move(State, Cards, Cards, CyclisteID, ChildNoeud1, CardsRestantes, Depth),
                                    move(State, CardsRestantes, Cards, CyclisteID, ChildNoeud2, _, Depth),
                                    (PlayerID = "Belgique"
                                        -> TmpChildNoeudList = [[[ChildNoeud1, StateIT, StateHO, StateAL, PlayerID], [ChildNoeud2, StateIT, StateHO, StateAL, PlayerID]]]
                                        ; write("")
                                    ),
                                    (PlayerID = "Italie"
                                        -> TmpChildNoeudList = [[[StateBE, ChildNoeud1, StateHO, StateAL, PlayerID], [StateBE, ChildNoeud2, StateHO, StateAL, PlayerID]]]
                                        ; write("")
                                    ),
                                    (PlayerID = "Hollande"
                                        -> TmpChildNoeudList = [[[StateBE, StateIT,ChildNoeud1, StateAL , PlayerID], [StateBE, StateIT,ChildNoeud2, StateAL , PlayerID]]]
                                        ; write("")
                                    ),
                                    (PlayerID = "Allemange"
                                        -> TmpChildNoeudList = [[[StateBE, StateIT, StateHO, ChildNoeud1 , PlayerID], [StateBE, StateIT,StateHO, ChildNoeud2, PlayerID]]]
                                        ; write("")
                                    ), append(TmpChildNoeudList, ChildNoeudList), !
                                ;   (Longueur = 1
                                        ->  move(State, Cards, Cards, CyclisteID, ChildNoeud1, _, Depth),
                                        (PlayerID = "Belgique"
                                            -> TmpChildNoeudList = [[ChildNoeud1, StateIT, StateHO, StateAL, PlayerID]]
                                            ; write("")
                                        ),
                                        (PlayerID = "Italie"
                                            -> TmpChildNoeudList = [[StateBE, ChildNoeud1, StateHO, StateAL, PlayerID]]
                                            ; write("")
                                        ),
                                        (PlayerID = "Hollande"
                                            -> TmpChildNoeudList = [[StateBE, StateIT,ChildNoeud1, StateAL , PlayerID]]
                                            ; write("")
                                        ),
                                        (PlayerID = "Allemange"
                                            -> TmpChildNoeudList = [[StateBE, StateIT, StateHO, ChildNoeud1 , PlayerID]]
                                            ; write("")
                                        ), append(TmpChildNoeudList, ChildNoeudList), !
                                        ;   writeln("KO")
                                    )
                            )
                    )
            )
    ).

    


move(State, CardsRestantes, Cards, CyclisteID, NewState, NewCardsRestantes, Depth) :- 
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

