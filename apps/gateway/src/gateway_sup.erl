%%%-------------------------------------------------------------------
%% @doc gateway top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(gateway_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
	RestartStrategy = one_for_one,
    MaxRestarts = 1000,
    MaxSecondsBetweenRestarts = 3600,

    SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},

    Restart = permanent,
    Shutdown = 2000,
    Type = supervisor,

    ServerTcpListenSup = {'server_tcp_listen_sup', {'server_tcp_listen_sup', start_link, []},
        Restart, Shutdown, Type, ['server_tcp_listen_sup']},
    ServerTcpAcceptorSup = {'server_tcp_acceptor_sup', {'server_tcp_acceptor_sup', start_link, []},
        Restart, Shutdown, Type, ['server_tcp_acceptor_sup']},
	ServerTcpClientSup = {'server_tcp_client_sup', {'server_tcp_client_sup', start_link, []},
        Restart, Shutdown, Type, ['server_tcp_client_sup']},

    {ok, {SupFlags, [ServerTcpListenSup,ServerTcpAcceptorSup,ServerTcpClientSup]}}.

%%====================================================================
%% Internal functions
%%====================================================================
