%% @author @author <285566130@qq.com>
%% @doc @todo Add description to server_tcp_client_sup.


-module(server_tcp_client_sup).
-behaviour(supervisor).
-export([init/1]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start_child/1,start_link/0]).



%% ====================================================================
%% Behavioural functions
%% ====================================================================
-spec(start_link() ->
  {ok, Pid :: pid()} | ignore | {error, Reason :: term()}).
start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% init/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/supervisor.html#Module:init-1">supervisor:init/1</a>
-spec init(Args :: term()) -> Result when
	Result :: {ok, {SupervisionPolicy, [ChildSpec]}} | ignore,
	SupervisionPolicy :: {RestartStrategy, MaxR :: non_neg_integer(), MaxT :: pos_integer()},
	RestartStrategy :: one_for_all
					 | one_for_one
					 | rest_for_one
					 | simple_one_for_one,
	ChildSpec :: {Id :: term(), StartFunc, RestartPolicy, Type :: worker | supervisor, Modules},
	StartFunc :: {M :: module(), F :: atom(), A :: [term()] | undefined},
	RestartPolicy :: permanent
				   | transient
				   | temporary,
	Modules :: [module()] | dynamic.
%% ====================================================================
init([]) ->
    RestartStrategy = simple_one_for_one,
	MaxRestarts = 1000,
	MaxSecondsBetweenRestarts = 3600,
	
	SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},
	
	Restart = temporary,
	Shutdown = 2000,
	Type = worker,
	
	ServerTcpClient = {'server_tcp_client', {'server_tcp_client', start_link, []},
	  Restart, Shutdown, Type, ['server_tcp_client']},
	
	{ok, {SupFlags, [ServerTcpClient]}}.

%% ====================================================================
%% Internal functions
%% ====================================================================
start_child(CSocket)->
	supervisor:start_child(?MODULE, [CSocket]).


