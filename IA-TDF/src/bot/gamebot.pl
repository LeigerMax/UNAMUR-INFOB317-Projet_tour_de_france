:- consult('plateau.pl').

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
    writeln('Cartes du joueur non trouvees : ' + PlayerId).


/******* POSITION CYCLISTES *******/

:- dynamic cyclist_position/4.

% Prédicat pour enregistrer la position d'un cycliste
set_cyclist_position(PlayerId, CyclistId, Ligne, Colonne) :-
    retractall(cyclist_position(PlayerId, CyclistId, _, _)),
    assertz(cyclist_position(PlayerId, CyclistId, Ligne, Colonne)).

% Prédicat pour récupérer la position d'un cycliste
get_cyclist_position(PlayerId, CyclistId, Ligne, Colonne) :-
   cyclist_position(PlayerId, CyclistId, Ligne, Colonne),
   writeln('Position du cycliste : ' + PlayerId + ' - ' + CyclistId + ' - (' + Ligne + ' ' + Colonne + ')'),
   !.
get_cyclist_position(PlayerId, CyclistId, _, _) :-
   writeln('Position du cycliste non trouvee : ' + PlayerId + ' - ' + CyclistId + '.').


/******* CHUTE *******/


