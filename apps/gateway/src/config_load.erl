%% @author 285566130@qq.com
%% @doc @todo Add description to config_load.


-module(config_load).
-include_lib("xmerl/include/xmerl.hrl").
%% ====================================================================
%% API functions
%% ====================================================================
-export([load/0]).


-record(map_info,{id,map_data_info_list=[]}).
-record(map_data_info,{height,width,tiled_map_info}).
%% ====================================================================
%% Internal functions
%% ====================================================================

load()->
%% 	Result = file:read_file("../priv/test.tmx"),
%% 	case Result of
%% 		{ok,Bin}->
			Path = code:priv_dir(gateway)++"/test.tmx",
			{ok,Xml} = file:read_file(Path),
%% 			{ok, State, TrailingCharacters} = erlsom:parse_sax(Xml, [], fun(Event, Acc) -> io:format("~p~n", [Event]), Acc end),
			{ok, Element, Tail} = erlsom:simple_form(Xml),
%% 			io:format("==========>>> tuple size = ~p~n",[erlang:tuple_size(Result)]),
%% 			io:format("Result = ~p~n", [Result]),
%% 			io:format("Result 1 = ~p~n", [Element]),
%% 			io:format("Result 2 = ~p~n", [Tail]),
			{Tag, Attributes, Content} = Element,
%% 			io:format("Tag = ~p~n", [Tag]),
			io:format("Attributes = ~p~n", [Attributes]),
			io:format("Content = ~p~n", [Content]),
			io:format("Content = ~p~n", [length(Content)]),
%% 			[C1,C2,C3,C4] = Content,
%% 			io:format("C1 = ~p, size = ~p~n", [C1,tuple_size(C1)]),
%% 			io:format("C2 = ~p, size = ~p~n", [C2,tuple_size(C2)]),
%% 			io:format("C3 = ~p, size = ~p~n", [C3,tuple_size(C3)]),
%% 			io:format("C4 = ~p, size = ~p~n", [C4,tuple_size(C4)]),
			
			F = fun(C,Acc)->
%% 				io:format("C~p = ~p, size = ~p~n", [Acc,C,tuple_size(C)]),
				content_callback(C),
				Acc+1
			end,
			lists:foldl(F,1, Content),
%% 	       Acc = fun(#xmlText{value = " ", pos = P}, Acc, S) ->
%% 				  {Acc, P, S};  % new return format
%% 			     (X, Acc, S) ->
%% 				  {[X|Acc], S}
%% 			  end,
%% 		   io:format("priv path = ~s~n", [code:priv_dir(gateway)]),
%% 		   io:format("cwd path = ~p~n", [file:get_cwd()]),
%% 			{TR,_} = xmerl_scan:file(Path,[{space,normalize},{acc_fun, Acc}]),
%% 			io:format("load read_file Result = ~p~n", [TR]),
%% 			io:format("load read_file Result = ~s~n", [binary_to_list(Bin)]),
%% 			ok;
%% 		_->
%% 			error
%% 	end,
%% 	io:format("load read_file Result = ~p~n", [Result]),
	ok.
content_callback({"tileset",ContentAttributes,ContentData})->
	ok;
content_callback({"imagelayer",ContentAttributes,ContentData})->
	ok;
content_callback({"layer",ContentAttributes,ContentData})->
	Height = list_to_integer(proplists:get_value("height", ContentAttributes)),
	Width = list_to_integer(proplists:get_value("width", ContentAttributes)),
	Name = proplists:get_value("name", ContentAttributes),
	{"data",EncodingInfo,[DataInfo]} = lists:keyfind("data", 1, ContentData),
%% 	io:format("DataInfo = ~p~n", [DataInfo]),
	TokenList = string:tokens(DataInfo,"\r\n"),
%% 	io:format("Format ---------->>> ~p~n", [string:tokens(DataInfo,"\r\n")]),
%% 	TokenList = lists:merge(string:replace(DataInfo, "\r\n", "",all)),
	FF = fun(Elem,{Dict,Num})->
				 io:format("Format=====>>> ~p~n", [Elem]),
				 {Dict,Num+1}
		 end,
	F = fun(Elem,Acc)->
			TempList = string:tokens(Elem, ","),
			lists:foldl(FF, {array:new([{size,Width}]),0}, TempList),
			io:format("Format ---->>> ~p~n", [TempList])
	end,
	lists:foldl(F, {array:new([{size,Height}]),0}, TokenList),
	#map_data_info{width = Width,height=Height},
	ok;
content_callback({"objectgroup",ContentAttributes,ContentData})->
	ok;
content_callback(_)->
	ok.
















	
	
	
	
	
	