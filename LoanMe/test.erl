%%%-------------------------------------------------------------------
%%% @author ADMIN
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. Jun 2019 19:10
%%%-------------------------------------------------------------------
-module(test).
-author("ADMIN").

%% API
-export([print_start/0]).

print_start() ->
  io:fwrite("Hello, world, User!\n"),
  Random_amount = rand:uniform(50),
  io:fwrite("~w",[Random_amount]).
