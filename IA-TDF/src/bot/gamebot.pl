/* --------------------------------------------------------------------- */
/*                                                                       */
/*                                Règles                                 */
/*                                                                       */
/* --------------------------------------------------------------------- */


/******* CARTES JOUEUR *******/

:- dynamic player_cards/2.

% Prédicat pour enregistrer les cartes d'un joueur
set_player_cards(PlayerId, Cards) :-
    retractall(player_cards(PlayerId, _)),
    assertz(player_cards(PlayerId, Cards)).

% Prédicat pour récupérer les cartes d'un joueur
get_player_cards(PlayerId, Cards) :-
    player_cards(PlayerId, Cards),
    !.
get_player_cards(PlayerId, []) :-
    writeln('Cartes du joueur non trouvées : ' + PlayerId).


/******* POSITION CYCLISTES *******/

:- dynamic cyclist_position/3.

% Prédicat pour enregistrer la position d'un cycliste
set_cyclist_position(PlayerId, CyclistId, PositionCycliste) :-
    retractall(cyclist_position(PlayerId, CyclistId, _)),
    assertz(cyclist_position(PlayerId, CyclistId, PositionCycliste)).

% Prédicat pour récupérer la position d'un cycliste
get_cyclist_position(PlayerId, CyclistId, PositionCycliste) :-
    cyclist_position(PlayerId, CyclistId, PositionCycliste),
    writeln('Position du cycliste  : ' + PlayerId + ' - ' + CyclistId + ' - ' + PositionCycliste).
    !.
get_cyclist_position(PlayerId, CyclistId, []) :-
    writeln('Position du cycliste non trouvée : ' | PlayerId | ' - ' | CyclistId).

