%%%-------------------------------------------------------------------
%%% @author <285566130@qq.com>
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. 十月 2017 17:12
%%%-------------------------------------------------------------------
-module(server_tcp_acceptor).

-behaviour(gen_server).
-include("log.hrl").
%% API
-export([start_link/4]).

%% gen_server callbacks
-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {listen_socket, ref}).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Starts the server
%%
%% @end
%%--------------------------------------------------------------------
start_link(IP,Port,Socket,Num) ->
  ModuleName = list_to_atom(IP ++ ":"++ integer_to_list(Port) ++":"++ integer_to_list(Num)),
  gen_server:start_link({local, ModuleName}, ?MODULE, [Socket], []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Initializes the server
%%
%% @spec init(Args) -> {ok, State} |
%%                     {ok, State, Timeout} |
%%                     ignore |
%%                     {stop, Reason}
%% @end
%%--------------------------------------------------------------------
-spec(init(Args :: term()) ->
  {ok, State :: #state{}} | {ok, State :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term()} | ignore).
init([LSocket]) ->
  process_flag(trap_exit, true),
  io:format("start init ~p~n",[?MODULE]),
  {ok, #state{listen_socket=LSocket}}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling call messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_call(Request :: term(), From :: {pid(), Tag :: term()},
    State :: #state{}) ->
  {reply, Reply :: term(), NewState :: #state{}} |
  {reply, Reply :: term(), NewState :: #state{}, timeout() | hibernate} |
  {noreply, NewState :: #state{}} |
  {noreply, NewState :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term(), Reply :: term(), NewState :: #state{}} |
  {stop, Reason :: term(), NewState :: #state{}}).
handle_call(_Request, _From, State) ->
	?DEBUG(liquan,"handle_call _Request = ~p",[_Request]),
  {reply, ok, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling cast messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_cast(Request :: term(), State :: #state{}) ->
  {noreply, NewState :: #state{}} |
  {noreply, NewState :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term(), NewState :: #state{}}).
handle_cast(_Request, State) ->
	?DEBUG(liquan,"handle_cast _Request = ~p",[_Request]),
  {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling all non call/cast messages
%%
%% @spec handle_info(Info, State) -> {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
-spec(handle_info(Info :: timeout() | term(), State :: #state{}) ->
  {noreply, NewState :: #state{}} |
  {noreply, NewState :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term(), NewState :: #state{}}).

handle_info({event, start}, State) ->
  accept(State);

handle_info({inet_async, LSock, Ref, {ok, Sock}}, State = #state{listen_socket=LSock, ref=Ref}) ->
  {ok, Mod} = inet_db:lookup_socket(LSock),
  inet_db:register_socket(Sock, Mod),
  try
    {ok, {Address, Port}} = inet:sockname(LSock),
    {ok, {PeerAddress, PeerPort}} = inet:peername(Sock),
    io:format("accepted TCP connection on ~s:~p from ~s:~p~n",
      [inet_parse:ntoa(Address), Port,
        inet_parse:ntoa(PeerAddress), PeerPort]),
    spawn_socket_controller(Sock)
  catch Error:Reason ->
    gen_tcp:close(Sock),
    io:format("unable to accept TCP connection: ~p ~p~n", [Error, Reason])
  end,
  accept(State);



handle_info(_Info, State) ->
	?DEBUG(liquan,"handle_info _Info =~p",[_Info]),
  {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
%%
%% @spec terminate(Reason, State) -> void()
%% @end
%%--------------------------------------------------------------------
-spec(terminate(Reason :: (normal | shutdown | {shutdown, term()} | term()),
    State :: #state{}) -> term()).
terminate(_Reason, _State) ->
  ok.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Convert process state when code is changed
%%
%% @spec code_change(OldVsn, State, Extra) -> {ok, NewState}
%% @end
%%--------------------------------------------------------------------
-spec(code_change(OldVsn :: term() | {down, term()}, State :: #state{},
    Extra :: term()) ->
  {ok, NewState :: #state{}} | {error, Reason :: term()}).
code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
spawn_socket_controller(ClientSock) ->
  io:format("~p~n", ["新的socket连接"]),
%%   	case gen_tcp:recv(ClientSock, 23, 30000) of
%% 	    {ok, Bin} ->
%% 			?INFO(liquan,"Bin = ~p",[Bin]),
		    case server_tcp_client_sup:start_child(ClientSock) of
			    {ok, CPid} ->
			      inet:setopts(ClientSock, [binary,{packet, 4},{active,9}]),
			      case gen_tcp:controlling_process(ClientSock, CPid) of
					  ok->
						  ?INFO(liquan,"controlling_process ok"),
					      CPid ! start;
					  {error,Reason}->
						  ?ERROR(liquan,"controlling_process error ~p",[Reason]),
						  error
				  end;
			    {error, Error} ->
			      io:format(liquan,"cannt accept client:~w", [Error]),
			      catch erlang:port_close(ClientSock)
		    end.
%% 	  	Other ->
%% 	            ?ERROR(liquan,"recv packet error:~w", [Other]),
%% 	            catch erlang:port_close(ClientSock)
%% 	end.

accept(State = #state{listen_socket=LSock}) ->
  case prim_inet:async_accept(LSock, -1) of
    {ok, Ref} ->
      {noreply, State#state{ref=Ref}};
    Error ->
      {stop, {cannot_accept, Error}, State}
  end.