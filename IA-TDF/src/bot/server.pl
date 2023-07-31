:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(lists)).
:- use_module(library(http/websocket)).


:- consult('tbot.pl').
:- consult('gamebot.pl').
:- consult('minmax.pl').
:- consult('plateau.pl').
:- consult('etat.pl').
:- consult('alphabeta.pl').


/* --------------------------------------------------------------------- */
/*                                                                       */
/*                            Création Serv                              */
/*                                                                       */
/* --------------------------------------------------------------------- */

:- http_handler(root(ws), http_upgrade_to_websocket(echo, []), [spawn([])]).

echo(WebSocket) :-
    ws_receive(WebSocket, Message, [format(json)]),
    %(   Message.opcode == close
    %->  true
    %;   
    get_response(Message.data, Response),
        writeln(Response),
        string_to_atom_list(Response, AtomResponse),
        produire_reponse(AtomResponse, ResponseBot),
        writeln(ResponseBot),
        ws_send(WebSocket, json(ResponseBot)),
        echo(WebSocket).
   % ).

run :-
    run(9999).

run(Port) :-
    http_server(http_dispatch, [port(Port)]).

stop :-
   stop(9999).

stop(Port) :-
   http_stop_server(Port, []).

%! get_response(+Message, -Response) is det.
% Pull the message content out of the JSON converted to a prolog dict
% then add the current time, then pass it back up to be sent to the
% client
get_response(Message, Response) :-
   Response = Message.content.

:- initialization run.

/* --------------------------------------------------------------------- */
/*                                                                       */
/*                           Nouvel écho de jeu                          */
/*                                                                       */
/* --------------------------------------------------------------------- */

:- http_handler(root(jeu_ws), http_upgrade_to_websocket(card_echo, []), [spawn([])]).

card_echo(WebSocket) :-
    ws_receive(WebSocket, Message, [format(json)]),
    (   Message.opcode == close
    ->  true
    ;   process_message(Message.data, Response),
        ws_send(WebSocket, json(Response)),
        card_echo(WebSocket)
    ).

/**************************** Cartes ****************************/
process_message(_{type: "playerCards", playerId: PlayerId, cards: Cards}, Response) :-
    process_player_cards(PlayerId, Cards, Response).


process_player_cards(PlayerId, Cards, Response) :-
    set_player_cards(PlayerId, Cards),  % Enregistre les cartes du joueur
    get_max_card(Cards, MaxCard), % Get la plus grande carte de la main
    Response = json{status: 'success', message: 'Cards received', type: "playerCards", playerId: PlayerId, cards: Cards, maxCard: MaxCard}.


/**************************** Joueur qui doit jouer  ****************************/  
process_message(_{type: "playerWhoPlay", playerId: PlayerId, cyclistId: CyclistId, count:Count}, Response) :-
    writeln("playerWhoPlay"),
    writeln(PlayerId),
    !,
    sleep(1),
    process_player_play(PlayerId, CyclistId, Count, Response).
    
process_player_play(PlayerId, CyclistId, Count, Response) :-
    get_player_cards(PlayerId, Cards), % Get les cartes du joueur
    writeln('Cartes du joueur : ' + Cards),
    Colonne is 1,
    (Count = 1
        ->  set_cyclist_play("Belgique", 1, 0),
            set_cyclist_play("Belgique", 2, 0),
            set_cyclist_play("Belgique", 3, 0),
            set_cyclist_play("Italie", 1, 0),
            set_cyclist_play("Italie", 2, 0),
            set_cyclist_play("Italie", 3, 0),
            set_cyclist_play("Hollande", 1, 0),
            set_cyclist_play("Hollande", 2, 0),
            set_cyclist_play("Hollande", 3, 0),
            set_cyclist_play("Allemagne", 1, 0),
            set_cyclist_play("Allemagne", 2, 0),
            set_cyclist_play("Allemagne", 3, 0)
            ; write("")
    ),
    %get_card_play(PlayerId, CyclistId, Cards, MaxCard, Colonne, Cards), % Get la plus grande carte de la main
    start_maxmax(PlayerId, CyclistId, MaxCard),
    (Count = 12
        ->  set_cyclist_play("Belgique", 1,0),
            set_cyclist_play("Belgique", 2,0),
            set_cyclist_play("Belgique", 3,0),
            set_cyclist_play("Italie", 1,0),
            set_cyclist_play("Italie", 2,0),
            set_cyclist_play("Italie", 3,0),
            set_cyclist_play("Hollande", 1,0),
            set_cyclist_play("Hollande", 2,0),
            set_cyclist_play("Hollande", 3,0),
            set_cyclist_play("Allemange", 1,0),
            set_cyclist_play("Allemange", 2,0),
            set_cyclist_play("Allemange", 3,0)
        ;   set_cyclist_play(PlayerId, CyclistId,1)
    ),
    writeln("MaxCard"+MaxCard),
    Response = json{status: 'success', message: 'Player find',type: "playerWhoPlay", playerId: PlayerId, maxCard: MaxCard, colonne: Colonne}.
    

/**************************** Position cyclistes ****************************/
process_message(_{type: "cyclistePosition", playerId: PlayerId, cyclistId: CyclistId, ligne: Ligne, colonne: Colonne}, Response) :-
    set_cyclist_position(PlayerId, CyclistId, Ligne, Colonne),
    process_player_cyclistePosition(PlayerId, CyclistId, Ligne, Colonne, Response).
 
process_player_cyclistePosition(PlayerId, CyclistId, Ligne, Colonne, Response) :-
    get_cyclist_position(PlayerId, CyclistId, Ligne, Colonne),
    Response = json{status: 'success', message: 'Cycliste Position', type: "cyclistePosition", playerId: PlayerId, cyclistId: CyclistId, ligne: Ligne, colonne: Colonne}.




/**************************** End Game ****************************/
process_message(_{type: "endGame"}, Response) :-
    process_end_game(Response).

process_end_game(Response) :-
    % Traitement de la fin du jeu
    stop,
    Response = json{status: 'success', message: 'End Game', type: "endGame"}.