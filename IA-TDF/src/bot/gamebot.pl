:- consult('plateau.pl').

/* --------------------------------------------------------------------- */
/*                                                                       */
/*                                Règles                                 */
/*                                                                       */
/* --------------------------------------------------------------------- */


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





