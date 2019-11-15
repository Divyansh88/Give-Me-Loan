%%%-------------------------------------------------------------------
%%% @author Divyansh
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. Jun 2019 20:04
%%%-------------------------------------------------------------------
-module(money).
-author("Divyansh").

%% API
-export([start/0]).

start() ->
  register(master, spawn(money, listen,[])),
  {ok ,List_customers} = file:consult("customers.txt"),
  io:fwrite("** Customers and loan objectives **~n"),
  Customer_map = maps:from_list(List_customers),
  printData(Customer_map),
  Customer_list = maps:keys(Customer_map),
  Customers = length(Customer_list),
  {ok ,List_banks} = file:consult("banks.txt"),
  io:fwrite("** Banks and financial resources **~n"),
  Bank_map = maps:from_list(List_banks),
  Bank_list = maps:keys(Bank_map),
  printData(Bank_map),

  lists:foreach(
    fun(Tuple_value)->
      Temp_cus = tuple_to_list(Tuple_value),
      register(lists:nth(1,Temp_cus), spawn(bank, childBank, [lists:nth(1,Temp_cus), lists:nth(2,Temp_cus), Customers])),
      sleep(100)
    end,
    List_banks
  ),
  lists:foreach(
    fun(Tuple_value)->
      Temp_cus = tuple_to_list(Tuple_value),
      register(lists:nth(1,Temp_cus), spawn(customer,childCustomer,[lists:nth(1,Temp_cus), lists:nth(2,Temp_cus), Bank_list, lists:nth(2,Temp_cus)])),
      sleep(100)
    end,
    List_customers
  ).

printData(Map_data) ->
  maps:fold(
    fun(K, V, ok) ->
      io:format("~p: ~p~n", [K, V])
    end, ok, Map_data),
  io:fwrite("~n").

sleep(T) ->
  receive
  after T ->
    true
  end.
