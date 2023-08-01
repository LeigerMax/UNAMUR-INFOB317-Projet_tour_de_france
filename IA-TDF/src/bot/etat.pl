:- consult('plateau.pl').

/******* CARTES JOUEUR *******/

:- dynamic player_cards/2.

% Enregistre les cartes d'un joueur
set_player_cards(PlayerId, Cards) :-
    retractall(player_cards(PlayerId, _)),
    assertz(player_cards(PlayerId, Cards)).

% Récupère les cartes d'un joueur
get_player_cards(PlayerId, Cards) :-
    player_cards(PlayerId, Cards),
    !.

% Récupère les cartes d'un joueur, mais pas de carte
get_player_cards(PlayerId, []) :-
    writeln('Cartes du joueur non trouvees : ' + PlayerId).


/******* POSITION CYCLISTES *******/

:- dynamic cyclist_position/4.

% Enregistre les positions des cyclistes
set_cyclist_position(PlayerId, CyclistId, Ligne, Colonne) :-
    retractall(cyclist_position(PlayerId, CyclistId, _, _)),
    assertz(cyclist_position(PlayerId, CyclistId, Ligne, Colonne)).

% Récupère les positions des cyclistes
get_cyclist_position(PlayerId, CyclistId, Ligne, Colonne) :-
   cyclist_position(PlayerId, CyclistId, Ligne, Colonne),
   %writeln('Position du cycliste : ' + PlayerId + ' - ' + CyclistId + ' - (' + Ligne + ' ' + Colonne + ')'),
   !.

% Récupère les positions des cyclistes, mais pas de position trouvés
get_cyclist_position(PlayerId, CyclistId, _, _) :-
   writeln('Position du cycliste non trouvee : ' + PlayerId + ' - ' + CyclistId + '.').

/******* STATE INIT *******/


% Traduit un identifiant
translate_player_name("Belgique", Belgique).
translate_player_name("Italie", Italie).
translate_player_name("Hollande", Hollande).
translate_player_name("Allemagne", Allemagne).


% Créer un état (State)
% [P1, P2, P3, P4] , [Val1, Val2, Val3, Val4]
% [C1 , C2, C3] , CARDS, CARD
% Ligne, Colonne)
stateInit(PlayerId, [Coureur1, Coureur2, Coureur3], Cards, Card, State):-
    translate_player_name(PlayerId, PaysVariable),
    get_cyclist_position(PlayerId, 1, Ligne1, Colonne1),
    get_cyclist_position(PlayerId, 2, Ligne2, Colonne2),
    get_cyclist_position(PlayerId, 3, Ligne3, Colonne3),
    get_player_cards(PlayerId, Cards),
    Coureur1 = (Ligne1, Colonne1),
    Coureur2 = (Ligne2, Colonne2),
    Coureur3 = (Ligne3, Colonne3),
    Card is 0,
    PaysVariable = ([Coureur1, Coureur2, Coureur3], Cards, Card),
    State = [PlayerId, [Coureur1, Coureur2, Coureur3], Cards, Card].



/******* PLAY CYCLISTES *******/


% Enregistre les cyclistes ayant jouer
set_cyclist_play(PlayerId, CyclisteId, Bool) :-
    retractall(cyclist_play(PlayerId, CyclisteId, _)),
    assertz(cyclist_play(PlayerId, CyclisteId, Bool)).

% Récupère les cyclistes ayant jouer
get_cyclist_play(PlayerId, CyclisteId, Bool) :-  
    cyclist_play(PlayerId, CyclisteId, Bool),
    !.


% Enregistre les cyclistes ayant jouer (temporaire)
set_cyclist_play_tmp(PlayerId, CyclisteId, Bool) :-
    retractall(cyclist_play_tmp(PlayerId, CyclisteId, _)),
    assertz(cyclist_play_tmp(PlayerId, CyclisteId, Bool)).

% Récupère les cyclistes ayant jouer (temporaire)
get_cyclist_play_tmp(PlayerId, CyclisteId, Bool) :-  
    cyclist_play_tmp(PlayerId, CyclisteId, Bool),
    !.
    

% Associe un cyclsite avec une profondeur
set_cyclist_depth(PlayerId, CyclisteId, Depth) :-
    retractall(cyclist_depth(PlayerId, CyclisteId, _)),
    assertz(cyclist_depth(PlayerId, CyclisteId, Depth)),
    writeln("SAVE "+PlayerId + CyclisteId + Depth).

% Récupère un cycliste en fonction de sa profondeur
get_cyclist_depth(PlayerId, CyclisteId, Depth) :-  
    cyclist_depth(PlayerId, CyclisteId, Depth),
    !.

% Supprime toutes les associations cycliste/profondeur
clear_cyclist_depth :-
    retractall(cyclist_depth(_, _, _)).
    