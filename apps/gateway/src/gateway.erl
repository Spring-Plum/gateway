%% @author <285566130@qq.com>
%% @doc @todo Add description to gateway.


-module(gateway).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0]).
-include("log.hrl").


%% ====================================================================
%% Internal functions
%% ====================================================================



start()->
%% 	application:start(syntax_tools),
%% 	application:start(goldrush),
	application:start(lager),
%% 	lager:start(),
	?INFO(liquan,"start loginserver ......"),
%% 	application:start(gateway),
	start_listen_proc(),
	?TEST_INFO("=============>>>> test lager info"),
	start_success.



start_listen_proc()->
	case application:get_env(gateway,listen_socket_info) of
	  {ok,ListenSocketInfoList}->
	    ?INFO(liquan,"load listen_socket_info =~p~n",[ListenSocketInfoList]),
		case ListenSocketInfoList of
			{IP,Port}->
				Num = 10;
			{IP,Port,Num}->
				ok;
			_->
				Num = 1,
				IP = "0.0.0.0",
				Port = 8888
		end,
        Temp = server_tcp_listen_sup:start_child(IP,Port,Num),
        ?DEBUG(liquan,"start server_tcp_listen_sup child result = ~p~n",[Temp]),
        ok;
	  _->
	    error
	end.
