-module(ws_handler).

-export([init/2]).
-export([websocket_init/1]).
-export([websocket_handle/2]).
-export([websocket_info/2,terminate/3]).

init(Req, Opts) ->
	{cowboy_websocket, Req, Opts}.

websocket_init(State) ->
	erlang:start_timer(1000, self(), <<"Hello!">>),
	{ok, State}.

websocket_handle({text, Msg}, State) ->
	{reply, {text, << "That's what she said! ", Msg/binary >>}, State};
websocket_handle(_Data, State) ->
	io:format("websocket_handle _Data = ~p~n", [_Data]),
	{ok, State}.

websocket_info({timeout, _Ref, Msg}, State) ->
	erlang:start_timer(1000, self(), <<"How' you doin'?">>),
	{reply, {text, Msg}, State};
websocket_info(_Info, State) ->
	io:format("websocket_info _Info = ~p~n", [_Info]),
	{ok, State}.

terminate(Any, Req, Any1) ->
	io:format("websocket_info terminate Any = ~p, Req = ~p, Any1 = ~p~n", [Any, Req, Any1]),
	ok.