%%%-------------------------------------------------------------------
%%% @author Divyansh
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. Jun 2019 20:05
%%%-------------------------------------------------------------------
-module(bank).
-author("Divyansh").

%% API
-export([childBank/3]).

childBank(Bank_name, Balance, Customers) ->
  receive
    {Parent_customer, Amount} ->
      if (Balance-Amount) >= 0 ->
        Parent_customer ! {approve, Amount},
        childBank(Bank_name, Balance - Amount, Customers);
      true ->
        Parent_customer ! {deny},
        childBank(Bank_name, Balance, Customers - 1)
      end

  after 2000 ->
      io:format("~p has ~p dollar(s) remaining. ~n ", [Bank_name, Balance])
  end.