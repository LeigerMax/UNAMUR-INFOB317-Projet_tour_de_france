:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(lists)).
:- use_module(library(http/websocket)).

:- consult('tbot.pl').

/* --------------------------------------------------------------------- */
/*                                                                       */
/*                            Création Serv                              */
/*                                                                       */
/* --------------------------------------------------------------------- */

:- http_handler(root(ws), http_upgrade_to_websocket(echo, []), [spawn([])]).

echo(WebSocket) :-
    ws_receive(WebSocket, Message, [format(json)]),
    (   Message.opcode == close
    ->  true
    ;   get_response(Message.data, Response),
        writeln(Response),
        string_to_atom_list(Response, AtomResponse),
        produire_reponse(AtomResponse, ResponseBot),
        writeln(ResponseBot),
        ws_send(WebSocket, json(ResponseBot)),
        echo(WebSocket)
    ).

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
/*                           Nouvel écho de cartes                        */
/*                                                                       */
/* --------------------------------------------------------------------- */

:- http_handler(root(card_ws), http_upgrade_to_websocket(card_echo, []), [spawn([])]).

card_echo(WebSocket) :-
    ws_receive(WebSocket, Message, [format(json)]),
    (   Message.opcode == close
    ->  true
    ;   process_card_message(Message.data, Response),
        ws_send(WebSocket, json(Response)),
        card_echo(WebSocket)
    ).

process_card_message(_{playerId: PlayerId, cards: Cards}, Response) :-
    writeln(PlayerId), % Afficher la valeur de PlayerId
    writeln(Cards),    % Afficher la valeur de Cards
    !,
    process_player_cards(PlayerId, Cards, Response).

process_player_cards(PlayerId, Cards, Response) :-
    Response = json{status: 'success', message: 'Cards received'}.
      
        


    

