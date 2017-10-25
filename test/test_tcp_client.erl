%% @author 285566130@qq.com
%% @doc @todo Add description to test_tcp_client.


-module(test_tcp_client).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([send/1,start_link/2,test/0,stop/0]).


%% ====================================================================
%% Behavioural functions
%% ====================================================================
-record(state, {socket}).

start_link(IP,Port)->
	gen_server:start_link({local,?MODULE},?MODULE, [IP,Port], []).


%% init/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:init-1">gen_server:init/1</a>
-spec init(Args :: term()) -> Result when
	Result :: {ok, State}
			| {ok, State, Timeout}
			| {ok, State, hibernate}
			| {stop, Reason :: term()}
			| ignore,
	State :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
init([IP,Port]) ->
	process_flag(trap_exit, true),
	case gen_tcp:connect(IP, Port, [binary,{packet, 4}]) of
		{ok,Socket}->
			gen_tcp:controlling_process(Socket, self()),
		    {ok, #state{socket=Socket}};
		{error,Reason}->
			{stop,Reason}
	end.
			


%% handle_call/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_call-3">gen_server:handle_call/3</a>
-spec handle_call(Request :: term(), From :: {pid(), Tag :: term()}, State :: term()) -> Result when
	Result :: {reply, Reply, NewState}
			| {reply, Reply, NewState, Timeout}
			| {reply, Reply, NewState, hibernate}
			| {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason, Reply, NewState}
			| {stop, Reason, NewState},
	Reply :: term(),
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity,
	Reason :: term().
%% ====================================================================
handle_call(Request, From, State) ->
	io:format("handle_call Request = ~p~n", [Request]),
    Reply = ok,
    {reply, Reply, State}.


%% handle_cast/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_cast-2">gen_server:handle_cast/2</a>
-spec handle_cast(Request :: term(), State :: term()) -> Result when
	Result :: {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason :: term(), NewState},
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
handle_cast(Msg, State) ->
	io:format("handle_cast Msg = ~p~n", [Msg]),
    {noreply, State}.


%% handle_info/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_info-2">gen_server:handle_info/2</a>
-spec handle_info(Info :: timeout | term(), State :: term()) -> Result when
	Result :: {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason :: term(), NewState},
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================


handle_info({tcp_closed,_}, State) ->
	io:format("handle_info Info = ~p~n", [tcp_closed]),
    {stop,normal, State};

handle_info(stop, #state{socket=Socket}=State) ->
	gen_tcp:close(Socket),
	io:format("handle_info stop ~n"),
    {stop,normal, State};

handle_info(test, #state{socket=Socket}=State) ->
	Result = gen_tcp:send(Socket, <<23:32,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1>>),
	io:format("handle_info send test Result = ~p~n", [Result]),
%% 	inet:setopts(Socket, [{packet, 4}]),
%% 	timer:sleep(1000),
	Result1 = gen_tcp:send(Socket, <<26:32,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,3,4>>),
%% 	Result2 = gen_tcp:send(Socket, <<28:32,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,3,4,5,6>>),
	io:format("handle_info send test Result = ~p~n", [Result1]),
%% 	io:format("handle_info send test Result = ~p~n", [Result2]),
    {noreply, State};
handle_info({send_msg,Msg}, #state{socket=Socket}=State) ->
	Result = gen_tcp:send(Socket, Msg),
	io:format("handle_info send Msg = ~p Result = ~p~n", [Msg,Result]),
    {noreply, State};
handle_info(Info, State) ->
	io:format("handle_info Info = ~p~n", [Info]),
    {noreply, State}.

%% terminate/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:terminate-2">gen_server:terminate/2</a>
-spec terminate(Reason, State :: term()) -> Any :: term() when
	Reason :: normal
			| shutdown
			| {shutdown, term()}
			| term().
%% ====================================================================
terminate(Reason, State) ->
    ok.


%% code_change/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:code_change-3">gen_server:code_change/3</a>
-spec code_change(OldVsn, State :: term(), Extra :: term()) -> Result when
	Result :: {ok, NewState :: term()} | {error, Reason :: term()},
	OldVsn :: Vsn | {down, Vsn},
	Vsn :: term().
%% ====================================================================
code_change(OldVsn, State, Extra) ->
    {ok, State}.


%% ====================================================================
%% Internal functions
%% ====================================================================
test()->
	?MODULE ! test.

stop()->
	?MODULE ! stop.

send(Msg)->
	?MODULE ! {send_msg,Msg}.