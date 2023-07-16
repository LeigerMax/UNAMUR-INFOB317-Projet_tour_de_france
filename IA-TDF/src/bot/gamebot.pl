/* --------------------------------------------------------------------- */
/*                                                                       */
/*                                Règles                                 */
/*                                                                       */
/* --------------------------------------------------------------------- */

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
