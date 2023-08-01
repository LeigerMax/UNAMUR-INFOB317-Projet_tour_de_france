:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- consult('etat.pl').

/******* START MAXMA *******/

% Lancement de l'algorithme maxmax
start_maxmax(PlayerId, CyclistId, MaxCard) :-
    writeln("STARTING MAXMAX"),
    Depth is 5, % 6 OK , +7 KO
    init_set_cyclist_play_tmp(),
    set_cyclist_depth(PlayerId, CyclistId, Depth),
    set_cyclist_play_tmp(PlayerId, CyclistId, 1),
    stateInit(PlayerId, _, Cards,_, StateForLoop),
    length(Cards, CardsTotal),
    (CardsTotal = 1 % Si une seule carte ne va pas dans l'algorithme maxmax, car obligé de jouer cette carte
        -> take_first_elem(Cards, MaxCard)
        ;
        run_depth_loop(StateForLoop, Depth),
        stateInit("Belgique", _, _,_, StateBE),
        stateInit("Italie", _, _,_, StateIT),
        stateInit("Hollande", _, _,_, StateHO),
        stateInit("Allemagne", _, _,_, StateAL),
        States = [StateBE, StateIT, StateHO, StateAL, PlayerId],
        maxmax(States, BestState, StateValue, Depth),
        decompose_state(BestState, StateBEAfter, StateITAfter, StateHOAfter, StateALAfter, PlayerId),
        (PlayerId = "Belgique"
            -> decompose(StateBEAfter, _, _, _, MaxCard)
            ; write("")
        ),
        (PlayerId = "Italie"
            -> decompose(StateITAfter, _, _, _, MaxCard)
            ; write("")
        ),
        (PlayerId = "Hollande"
            -> decompose(StateHOAfter, _, _, _, MaxCard)
            ; write("")
        ),
        (PlayerId = "Allemagne"
            ->  decompose(StateALAfter, _, _, _, MaxCard)
            ; write("")
        )
    ),
    clear_cyclist_depth,
    writeln("Valeur du meilleur coup " + [StateValue]),
    writeln("Meilleur coup " + [BestState]),
    writeln("Carte a jouer  " + [MaxCard]).
    
% Prédicat init set_cyclist_play_tmp
init_set_cyclist_play_tmp() :-
    set_cyclist_play_tmp("Belgique", 1, 0),
    set_cyclist_play_tmp("Belgique", 2, 0),
    set_cyclist_play_tmp("Belgique", 3, 0),
    set_cyclist_play_tmp("Italie", 1, 0),
    set_cyclist_play_tmp("Italie", 2, 0),
    set_cyclist_play_tmp("Italie", 3, 0),
    set_cyclist_play_tmp("Hollande", 1, 0),
    set_cyclist_play_tmp("Hollande", 2, 0),
    set_cyclist_play_tmp("Hollande", 3, 0),
    set_cyclist_play_tmp("Allemagne", 1, 0),
    set_cyclist_play_tmp("Allemagne", 2, 0),
    set_cyclist_play_tmp("Allemagne", 3, 0).

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
    stateInit(PlayerID, _, _,_, State).

% Prochain joueur à jouer
nextPlayer("Belgique", "Italie").
nextPlayer("Italie", "Hollande").
nextPlayer("Hollande", "Allemange").
nextPlayer("Allemagne", "Belgique").

% Prédicat qui permet d'assigner les cyclistes à une profondeur (Depth)
whoCyclistePlay(State, Depth) :-
    decompose(State, Country, Cyclists, Cards, _),
    decompose_cyclists(Cyclists, Cyclist1, Cyclist2, Cyclist3),
    Cyclist1 = (Ligne1, _),
    Cyclist2 = (Ligne2, _),
    Cyclist3 = (Ligne3, _),
    (
        Ligne1 =:= 0,
        get_cyclist_play(Country, 1, Bool1),
        get_cyclist_play_tmp(Country, 1, BoolTmp1),
        Bool1 = 0,
        BoolTmp1 = 0
    ->
        CyclistID = 1,
        set_cyclist_depth(Country, 1, Depth),
        set_cyclist_play_tmp(Country, 1, 1),
        NewDepth is Depth - 1,
        writeln("")
    ;
    Ligne2 =:= 0,
    get_cyclist_play(Country, 2, Bool2),
    get_cyclist_play_tmp(Country, 2, BoolTmp2),
    Bool2 = 0,
    BoolTmp2 = 0
    ->
        CyclistID = 2,
        set_cyclist_depth(Country, 2, Depth),
        set_cyclist_play_tmp(Country, 2, 1),
        NewDepth is Depth - 1,
        writeln("")
    ;
    Ligne3 =:= 0,
    get_cyclist_play(Country, 3, Bool3),
    get_cyclist_play_tmp(Country, 3, BoolTmp3),
    Bool3 = 0,
    BoolTmp3 = 0
    ->
        CyclistID = 3,
        set_cyclist_depth(Country, 3, Depth),
        set_cyclist_play_tmp(Country, 3, 1),
        NewDepth is Depth - 1,
        writeln("")
    ;
    smallest_line(Country, Ligne1, Ligne2, Ligne3, MinLine),
        ((get_cyclist_play(Country, 1, Bool1), Bool1 = 0, get_cyclist_play_tmp(Country, 1, 0), Cyclist1 = (MinLine, _)) -> CyclistID = 1, set_cyclist_depth(Country, 1, Depth), set_cyclist_play_tmp(Country, 1, 1), NewDepth is Depth - 1
        ; (get_cyclist_play(Country, 2, Bool2), Bool2 = 0, get_cyclist_play_tmp(Country, 2, 0), Cyclist2 = (MinLine, _)) -> CyclistID = 2, set_cyclist_depth(Country, 2, Depth), set_cyclist_play_tmp(Country, 2, 1), NewDepth is Depth - 1
        ; (get_cyclist_play(Country, 3, Bool3), Bool3 = 0, get_cyclist_play_tmp(Country, 3, 0), Cyclist3 = (MinLine, _)) -> CyclistID = 3, set_cyclist_depth(Country, 3, Depth), set_cyclist_play_tmp(Country, 3, 1), NewDepth is Depth - 1
        ; (nextPlayer(Country, NewCountry), stateBase(NewCountry, NewState), whoCyclistePlay(NewState, Depth))
        )
    ),
    !.


% Prédicat pour trouver la plus petite ligne parmi trois valeurs
smallest_line(Country,L1, L2, L3, MinLine) :-
    (get_cyclist_play_tmp(Country, 1, 1) -> NewL1 is 9999; NewL1 is L1),
    (get_cyclist_play_tmp(Country, 2, 1) -> NewL2 is 9999; NewL2 is L2),
    (get_cyclist_play_tmp(Country, 3, 1) -> NewL3 is 9999; NewL3 is L3),
    MinLine is min(min(NewL1, NewL2), NewL3).


/***********************/



/******* MAX MAX *******/


% Cherche les enfants de State, evalue les states
maxmax(State, BestState, StateValue, Depth) :-
    Depth > 0,
    move(State, ChildStateList, Depth),
    NewDepth is Depth - 1, 
    bestmove(ChildStateList, BestState, StateValue, NewDepth), !
    ;
    evaluate(State, StateValue).


/***********************/



/******* BEST MOVE *******/

% Sélectionne le meilleur move / state avec la valeur la plus haute
bestmove([], _, _, _, _).

bestmove([State], State, StateValue, Depth) :-
    maxmax(State, _, StateValue, Depth), !. 

bestmove([ChildState | ChildStateList], BestState, BestValueState, Depth) :-
    maxmax(ChildState, _, FirstStateValue, Depth),
    bestmove(ChildStateList, SecondState, SecondStateValue, Depth),
    betterof(ChildState, FirstStateValue, SecondState, SecondStateValue, BestState, BestValueState).


/**************************/


/******* BETTER OF *******/

% Calcul le meilleur state et la meilleur valeur
betterof(FirstState, FirstStateValue, SecondState, SecondStateValue, FirstState, FirstStateValue) :-
    %writeln("TEST BETTEROF FirstState " + FirstState),
    %writeln("TEST BETTEROF FirstStateValue " + FirstStateValue),
    %writeln("TEST BETTEROF SecondState " + SecondState),
    %writeln("TEST BETTEROF SecondStateValue " + SecondStateValue),
    sum_list(FirstStateValue, SumFirstStateValue),
    sum_list(SecondStateValue, SumSecondStateValue),
    %writeln("SumFirstStateValue " + SumFirstStateValue),
    %writeln("SumSecondStateValue " + SumSecondStateValue),
    SumFirstStateValue > SumSecondStateValue.

betterof(_, _, SecondState, SecondStateValue, SecondState, SecondStateValue).


/*************************/



/******* EVALUATE *******/

% Renvoie la valeur d'un état donné suivant une heuristique
%
% Chute : val - 20                          OK
% Case chance : Val - 3                     OK
% Ligne arrivé (102) : Val + 20             OK
% Case supplémentaire (103 - 112): Val      OK
% Case vierge : Val                         OK      
% Case 89 - 102 : Val + 2                   OK
evaluate([Belgique, Italie, Hollande, Allemagne, PlayerCurrent], [Val1, Val2, Val3, Val4]) :-
    decompose(Belgique, _ , CyclistsBE, Cards1, _),
    decompose_cyclists(CyclistsBE, Be1, Be2, Be3),
    player_eval([Be1, Be2, Be3], Cards1, Val1),

    decompose(Italie, _ , CyclistsIT, Cards2, _),
    decompose_cyclists(CyclistsIT, It1, It2, It3),
    player_eval([It1, It2, It3], Cards2, Val2),

    decompose(Hollande, _ , CyclistsHO, Cards3, _),
    decompose_cyclists(CyclistsHO, Hol1, Hol2, Hol3),
    player_eval([Hol1, Hol2, Hol3], Cards3, Val3),

    decompose(Allemagne, _ , CyclistsAL, Cards4, _),
    decompose_cyclists(CyclistsAL, All1, All2, All3),
    player_eval([All1, All2, All3], Cards4, Val4).

% Evaluation d'un joueur
player_eval([Cyclist1, Cyclist2, Cyclist3], Cards, Val):-
    cyclist_eval(Cyclist1, Cards, Val1),
    cyclist_eval(Cyclist2, Cards, Val2),
    cyclist_eval(Cyclist3, Cards, Val3),
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

% Note :
%Les cartes restantes à tester      : CardsRestantes
%La carte jouer 	                : CardPlay
%Le deck complet		            : Cards
%Les cartes qui n'ont pas été jouer : CardsDontPlay

% Prédicat permettant de constuire les enfants de State
move(States, ChildStateList, Depth) :-
    decompose_state(States, StateBE, StateIT, StateHO, StateAL, Player),
    get_cyclist_depth(PlayerID, CyclistID, Depth),
    %writeln("Player "+Player+ "CyclistID "+ CyclistID+ " Depth "+ Depth),
    (PlayerID = "Belgique"
        -> decompose(StateBE, Country, Coureurs, Cards, _), State = StateBE
        ; write("")
    ),
    (PlayerID = "Italie"
        -> decompose(StateIT, Country, Coureurs, Cards, _), State = StateIT
        ; write("")
    ),
    (PlayerID = "Hollande"
        -> decompose(StateHO, Country, Coureurs, Cards, _), State = StateHO
        ; write("")
    ),
    (PlayerID = "Allemagne"
        -> decompose(StateAL, Country, Coureurs, Cards, _), State = StateAL
        ; write("")
    ),
    length(Cards, Longueur),
    (Longueur = 5
        ->   move(State, Cards, Cards, CyclistID, ChildState1, CardsRestantes, Depth),
             move(State, CardsRestantes, Cards, CyclistID, ChildState2, CardsRestantes2, Depth),
             move(State, CardsRestantes2, Cards, CyclistID, ChildState3, CardsRestantes3, Depth),
             move(State, CardsRestantes3, Cards, CyclistID, ChildState4, CardsRestantes4, Depth),
             move(State, CardsRestantes4, Cards, CyclistID, ChildState5, CardsRestantes5, Depth),
             (PlayerID = "Belgique"
                -> TmpChildStateList = [[[ChildState1, StateIT, StateHO, StateAL, PlayerID], [ChildState2, StateIT, StateHO, StateAL, PlayerID], [ChildState3, StateIT, StateHO, StateAL, PlayerID], [ChildState4, StateIT, StateHO, StateAL, PlayerID], [ChildState5, StateIT, StateHO, StateAL, PlayerID]]]
                ; write("")
            ),
            (PlayerID = "Italie"
                -> TmpChildStateList = [[[StateBE, ChildState1, StateHO, StateAL, PlayerID], [StateBE, ChildState2, StateHO, StateAL, PlayerID], [StateBE, ChildState3, StateHO, StateAL, PlayerID], [StateBE, ChildState4, StateHO, StateAL, PlayerID], [StateBE, ChildState5, StateHO, StateAL, PlayerID]]]
                ; write("")
            ),
            (PlayerID = "Hollande"
                -> TmpChildStateList = [[[StateBE, StateIT,ChildState1, StateAL , PlayerID], [StateBE, StateIT,ChildState2, StateAL , PlayerID], [StateBE, StateIT,ChildState3, StateAL , PlayerID], [StateBE, StateIT,ChildState4, StateAL , PlayerID], [StateBE, StateIT,ChildState5, StateAL , PlayerID]]]
                ; write("")
            ),
            (PlayerID = "Allemagne"
                -> TmpChildStateList = [[[StateBE, StateIT, StateHO, ChildState1 , PlayerID], [StateBE, StateIT,StateHO, ChildState2, PlayerID], [StateBE, StateIT,StateHO, ChildState3 , PlayerID], [StateBE, StateIT,StateHO, ChildState4 , PlayerID], [StateBE, StateIT,StateHO, ChildState5, PlayerID]]]
                ; write("")
            ), append(TmpChildStateList, ChildStateList), !
        ;   (Longueur = 4
                ->  move(State, Cards, Cards, CyclistID, ChildState1, CardsRestantes, Depth),
                    move(State, CardsRestantes, Cards, CyclistID, ChildState2, CardsRestantes2, Depth),
                    move(State, CardsRestantes2, Cards, CyclistID, ChildState3, CardsRestantes3, Depth),
                    move(State, CardsRestantes3, Cards, CyclistID, ChildState4, CardsRestantes4, Depth),
                    (PlayerID = "Belgique"
                        -> TmpChildStateList = [[[ChildState1, StateIT, StateHO, StateAL, PlayerID], [ChildState2, StateIT, StateHO, StateAL, PlayerID], [ChildState3, StateIT, StateHO, StateAL, PlayerID], [ChildState4, StateIT, StateHO, StateAL, PlayerID]]]
                        ; write("")
                    ),
                    (PlayerID = "Italie"
                        -> TmpChildStateList = [[[StateBE, ChildState1, StateHO, StateAL, PlayerID], [StateBE, ChildState2, StateHO, StateAL, PlayerID], [StateBE, ChildState3, StateHO, StateAL, PlayerID], [StateBE, ChildState4, StateHO, StateAL, PlayerID]]]
                        ; write("")
                    ),
                    (PlayerID = "Hollande"
                        -> TmpChildStateList = [[[StateBE, StateIT,ChildState1, StateAL , PlayerID], [StateBE, StateIT,ChildState2, StateAL , PlayerID], [StateBE, StateIT,ChildState3, StateAL , PlayerID], [StateBE, StateIT,ChildState4, StateAL , PlayerID]]]
                        ; write("")
                    ),
                    (PlayerID = "Allemagne"
                        -> TmpChildStateList = [[[StateBE, StateIT, StateHO, ChildState1 , PlayerID], [StateBE, StateIT,StateHO, ChildState2, PlayerID], [StateBE, StateIT,StateHO, ChildState3 , PlayerID], [StateBE, StateIT,StateHO, ChildState4 , PlayerID]]]
                        ; write("")
                    ), append(TmpChildStateList, ChildStateList), !
                ;   (Longueur = 3
                        ->  move(State, Cards, Cards, CyclistID, ChildState1, CardsRestantes, Depth),
                            move(State, CardsRestantes, Cards, CyclistID, ChildState2, CardsRestantes2, Depth),
                            move(State, CardsRestantes2, Cards, CyclistID, ChildState3, CardsRestantes3, Depth),
                            (PlayerID = "Belgique"
                                -> TmpChildStateList = [[[ChildState1, StateIT, StateHO, StateAL, PlayerID], [ChildState2, StateIT, StateHO, StateAL, PlayerID], [ChildState3, StateIT, StateHO, StateAL, PlayerID]]]
                                ; write("")
                            ),
                            (PlayerID = "Italie"
                                -> TmpChildStateList = [[[StateBE, ChildState1, StateHO, StateAL, PlayerID], [StateBE, ChildState2, StateHO, StateAL, PlayerID], [StateBE, ChildState3, StateHO, StateAL, PlayerID]]]
                                ; write("")
                            ),
                            (PlayerID = "Hollande"
                                -> TmpChildStateList = [[[StateBE, StateIT,ChildState1, StateAL , PlayerID], [StateBE, StateIT,ChildState2, StateAL , PlayerID], [StateBE, StateIT,ChildState3, StateAL , PlayerID]]]
                                ; write("")
                            ),
                            (PlayerID = "Allemagne"
                                -> TmpChildStateList = [[[StateBE, StateIT, StateHO, ChildState1 , PlayerID], [StateBE, StateIT,StateHO, ChildState2, PlayerID], [StateBE, StateIT,StateHO, ChildState3 , PlayerID]]]
                                ; write("")
                            ), append(TmpChildStateList, ChildStateList), !
                        ;   (Longueur = 2
                                ->  move(State, Cards, Cards, CyclistID, ChildState1, CardsRestantes, Depth),
                                    move(State, CardsRestantes, Cards, CyclistID, ChildState2, _, Depth),
                                    (PlayerID = "Belgique"
                                        -> TmpChildStateList = [[[ChildState1, StateIT, StateHO, StateAL, PlayerID], [ChildState2, StateIT, StateHO, StateAL, PlayerID]]]
                                        ; write("")
                                    ),
                                    (PlayerID = "Italie"
                                        -> TmpChildStateList = [[[StateBE, ChildState1, StateHO, StateAL, PlayerID], [StateBE, ChildState2, StateHO, StateAL, PlayerID]]]
                                        ; write("")
                                    ),
                                    (PlayerID = "Hollande"
                                        -> TmpChildStateList = [[[StateBE, StateIT,ChildState1, StateAL , PlayerID], [StateBE, StateIT,ChildState2, StateAL , PlayerID]]]
                                        ; write("")
                                    ),
                                    (PlayerID = "Allemagne"
                                        -> TmpChildStateList = [[[StateBE, StateIT, StateHO, ChildState1 , PlayerID], [StateBE, StateIT,StateHO, ChildState2, PlayerID]]]
                                        ; write("")
                                    ), append(TmpChildStateList, ChildStateList), !
                                ;   (Longueur = 1
                                        ->  move(State, Cards, Cards, CyclistID, ChildState1, _, Depth),
                                        (PlayerID = "Belgique"
                                            -> TmpChildStateList = [[ChildState1, StateIT, StateHO, StateAL, PlayerID]]
                                            ; write("")
                                        ),
                                        (PlayerID = "Italie"
                                            -> TmpChildStateList = [[StateBE, ChildState1, StateHO, StateAL, PlayerID]]
                                            ; write("")
                                        ),
                                        (PlayerID = "Hollande"
                                            -> TmpChildStateList = [[StateBE, StateIT,ChildState1, StateAL , PlayerID]]
                                            ; write("")
                                        ),
                                        (PlayerID = "Allemagne"
                                            -> TmpChildStateList = [[StateBE, StateIT, StateHO, ChildState1 , PlayerID]]
                                            ; write("")
                                        ), append(TmpChildStateList, ChildStateList),  !
                                        ;   writeln("KO")
                                    )
                            )
                    )
            )
    ).


move(State, CardsRestantes, Cards, CyclistID, NewState, NewCardsRestantes, Depth) :- 
    take_card(CardsRestantes,Card),
    avancer_cycliste2(State,CardsRestantes, CyclistID, Card, Cards, NewState, NewCardsRestantes).
    

% Prédicat pour prendre la première carte d'une main
take_card([Card | Cards], Card).
take_card([_,Cards], Card) :-
    take_card(Cards,Card).


% Récupérer les cartes du joueur
get_player_cards(PlayerId, Cards).

% Simule l'avancement d'un cycliste 
avancer_cycliste2(State,CardsRestantes, SelectedCyclist, Card, Cards, NewState, NewCardsRestantes) :-
    decompose(State, Country, Coureurs, Cards, _),
    decompose_cyclists(Coureurs, Cyclist1, Cyclist2, Cyclist3),
    (SelectedCyclist = 1
        -> Cyclist1 = (LigneAvant, Colonne),
           NewLigne is LigneAvant + Card,
           NewColonne is 1,
           remove_first_elem(CardsRestantes, NewCardsRestantes),
           remove_card2(Card, Cards, CardsDontPlay),
           NewState = [Country, [(NewLigne, NewColonne),Cyclist2, Cyclist3], CardsDontPlay, Card]
        ; (SelectedCyclist = 2
            ->  Cyclist2 = (LigneAvant, Colonne),
                NewLigne is LigneAvant + Card,
                NewColonne is 1,
                remove_first_elem(CardsRestantes, NewCardsRestantes),
                remove_card2(Card, Cards, CardsDontPlay),
                NewState = [Country, [Cyclist1,(NewLigne, NewColonne), Cyclist3], CardsDontPlay, Card] 
            ; (SelectedCyclist = 3
                ->  Cyclist3 = (LigneAvant, Colonne),
                    NewLigne is LigneAvant + Card,
                    NewColonne is 1,
                    remove_first_elem(CardsRestantes, NewCardsRestantes),
                    remove_card2(Card, Cards, CardsDontPlay),
                    NewState = [Country, [Cyclist1,Cyclist2, (NewLigne, NewColonne)], CardsDontPlay, Card] 
                ; writeln("KO")
                )
            )
    ),
    writeln("NewState "+NewState).



/*************************/

% Prédicat pour retirer le premier elem d'une liste
remove_first_elem([_|Rest], Rest).

% Prédicat pour récupérer le premier elem d'une liste
take_first_elem([Elem|Rest], Elem).

% Prédicat pour retirer une carte d'une liste de cartes
remove_card2(Card, Cards, NewCards) :-
    select(Card, Cards, NewCards).

% Décomposition de States
decompose_state(State, StateBE, StateIT, StateHO, StateAL, PlayerID) :-
    State = [StateBE, StateIT, StateHO, StateAL, PlayerID].

% Compositon de States
compose_state(State, StateBE, StateIT, StateHO, StateAL, PlayerID) :-
    State = [StateBE, StateIT, StateHO, StateAL, PlayerID].


% Décomposition de State
decompose(State, Country, Cyclists, Cards, Card) :-
    State = [Country, Cyclists, Cards, Card].


% Décomposition de la liste des coureurs
decompose_cyclists([], [], [], []).
decompose_cyclists([(A, B) | Reste], Cyclist1, Cyclist2, Cyclist3) :-
    Cyclist1 = (A, B),
    decompose_cyclists(Reste, Cyclist2, Cyclist3, []).