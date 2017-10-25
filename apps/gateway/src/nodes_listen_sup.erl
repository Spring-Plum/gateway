%% @author <285566130@qq.com>
%% @doc @todo Add description to nodes_listen_sup.


-module(nodes_listen_sup).
-behaviour(supervisor).
-export([init/1]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start_link/0]).



%% ====================================================================
%% Behavioural functions
%% ====================================================================
start_link()->
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
      RestartStrategy = one_for_one,
	  MaxRestarts = 1000,
	  MaxSecondsBetweenRestarts = 3600,
	
	  SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},
	
	  Restart = permanent,
	  Shutdown = infinity,
	  Type = worker,
	
	  NodesListen = {'nodes_listen', {'nodes_listen', start_link, []},
	    Restart, Shutdown, Type, ['nodes_listen']},
	
	  {ok, {SupFlags, [NodesListen]}}.

%% ====================================================================
%% Internal functions
%% ====================================================================


