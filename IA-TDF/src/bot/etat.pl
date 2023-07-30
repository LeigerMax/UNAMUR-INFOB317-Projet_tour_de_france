:- consult('plateau.pl').

/******* CARTES JOUEUR *******/

:- dynamic player_cards/2.

% Enregistre les cartes d'un joueur
% Entrées : PlayerId, Cards
set_player_cards(PlayerId, Cards) :-
    retractall(player_cards(PlayerId, _)),
    assertz(player_cards(PlayerId, Cards)).

% Récupère les cartes d'un joueur
% Entrées : PlayerId
% Sorties : Cards
get_player_cards(PlayerId, Cards) :-
    player_cards(PlayerId, Cards),
    !.

% Récupère les cartes d'un joueur, mais pas de carte
% Entrées : PlayerId
% Sorties : []
get_player_cards(PlayerId, []) :-
    writeln('Cartes du joueur non trouvees : ' + PlayerId).


/******* POSITION CYCLISTES *******/

:- dynamic cyclist_position/4.

% Enregistre les positions des cyclistes
% Entrées : PlayerId, CyclistId, Ligne, Colonne
set_cyclist_position(PlayerId, CyclistId, Ligne, Colonne) :-
    retractall(cyclist_position(PlayerId, CyclistId, _, _)),
    assertz(cyclist_position(PlayerId, CyclistId, Ligne, Colonne)).

% Récupère les positions des cyclistes
% Entrées : PlayerId, CyclistId
% Sorties : Ligne, Colonne
get_cyclist_position(PlayerId, CyclistId, Ligne, Colonne) :-
   cyclist_position(PlayerId, CyclistId, Ligne, Colonne),
   %writeln('Position du cycliste : ' + PlayerId + ' - ' + CyclistId + ' - (' + Ligne + ' ' + Colonne + ')'),
   !.

% Récupère les positions des cyclistes, mais pas de position trouvés
% Entrées : PlayerId, CyclistId
% Sorties : _, _
get_cyclist_position(PlayerId, CyclistId, _, _) :-
   writeln('Position du cycliste non trouvee : ' + PlayerId + ' - ' + CyclistId + '.').

/******* STATE INIT *******/

translate_player_name("Belgique", Belgique).
translate_player_name("Italie", Italie).
translate_player_name("Hollande", Hollande).
translate_player_name("Allemagne", Allemagne).


% StateInit
% [P1, P2, P3, P4] , [Val1, Val2, Val3, Val4]
%% [C1 , C2, C3] , CARDS
%%% (Ligne, Colonne)
stateInit(PlayerId, [Coureur1, Coureur2, Coureur3], Cards, State):-
    translate_player_name(PlayerId, PaysVariable),
    get_cyclist_position(PlayerId, 1, Ligne1, Colonne1),
    get_cyclist_position(PlayerId, 2, Ligne2, Colonne2),
    get_cyclist_position(PlayerId, 3, Ligne3, Colonne3),
    get_player_cards(PlayerId, Cards),
    Coureur1 = (Ligne1, Colonne1),
    Coureur2 = (Ligne2, Colonne2),
    Coureur3 = (Ligne3, Colonne3),
    PaysVariable = ([Coureur1, Coureur2, Coureur3], Cards),
    State = [PlayerId, [Coureur1, Coureur2, Coureur3], Cards].



/******* Cyclist Play *******/

set_cyclist_play(PlayerId, CyclisteId, Bool) :-
    retractall(cyclist_play(PlayerId, CyclisteId, _)),
    assertz(cyclist_play(PlayerId, CyclisteId, Bool)).


get_cyclist_play(PlayerId, CyclisteId, Bool) :-  
    cyclist_play(PlayerId, CyclisteId, Bool),
    !.



set_cyclist_play_tmp(PlayerId, CyclisteId, Bool) :-
    retractall(cyclist_play_tmp(PlayerId, CyclisteId, _)),
    assertz(cyclist_play_tmp(PlayerId, CyclisteId, Bool)).


get_cyclist_play_tmp(PlayerId, CyclisteId, Bool) :-  
    cyclist_play_tmp(PlayerId, CyclisteId, Bool),
    !.
    


set_cyclist_depth(PlayerId, CyclisteId, Depth) :-
    retractall(cyclist_depth(PlayerId, CyclisteId, _)),
    assertz(cyclist_depth(PlayerId, CyclisteId, Depth)),
    writeln("SAVE "+PlayerId + CyclisteId + Depth).


get_cyclist_depth(PlayerId, CyclisteId, Depth) :-  
    cyclist_depth(PlayerId, CyclisteId, Depth),
    !.