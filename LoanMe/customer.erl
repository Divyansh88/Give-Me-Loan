%%%-------------------------------------------------------------------
%%% @author Divyansh
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. Jun 2019 21:34
%%%-------------------------------------------------------------------
-module(customer).
-author("Divyansh").

%% API
-export([childCustomer/4]).

childCustomer(Customer_name, Amount, Bank_list, Actual_amount) ->
  if
    Amount /= 0 ->
      if
        length(Bank_list) /= 0 ->
         Random_amount =  if
                            Amount < 50 ->
                              rand:uniform(Amount);
                            true ->
                              rand:uniform(50)
                          end,

          Random_bank = lists:nth(rand:uniform(length(Bank_list)), Bank_list),
          if
            Random_amount /= 0 ->
              Low = 10,
              High = 100,
              Random_sleep = rand:uniform(High - Low) + Low,
              sleep(Random_sleep),
              io:format("~p requests a loan of ~p dollar(s) from ~p ~n ", [Customer_name, Random_amount, Random_bank]),
              Pid = whereis(Random_bank),
              Pid ! {self(), Random_amount};
            true ->
              true
          end,

          receive
            {approve, Random_amount} ->
              io:format("~p approves a loan of ~p dollar(s) from ~p ~n ", [Random_bank, Random_amount, Customer_name]),
              childCustomer(Customer_name, Amount - Random_amount, Bank_list, Actual_amount);

            {deny} ->
              io:format("~p denies a loan of ~p dollar(s) from ~p ~n ", [Random_bank, Random_amount, Customer_name]),
              childCustomer(Customer_name, Amount, lists:filter(fun(Elem) -> not lists:member(Elem, [Random_bank]) end, Bank_list), Actual_amount)
          end;

        true ->
          if
            Amount == 0 ->
              io:format("~p has reached the objective of ~p dollar(s). Woo Hoo!~n ", [Customer_name, Actual_amount]);
            Amount > 0 ->
              io:format("~p was only able to borrow ~p dollar(s). Boo Hoo! ~n ", [Customer_name, Actual_amount - Amount]);
            true ->
              true
          end
      end;
    true ->
      if
        Amount == 0 ->
          io:format("~p has reached the objective of ~p dollar(s). Woo Hoo!~n ", [Customer_name, Actual_amount]);
        Amount > 0 ->
          io:format("~p was only able to borrow ~p dollar(s). Boo Hoo! ~n ", [Customer_name, Actual_amount - Amount]);
        true ->
          true
      end
  end.

sleep(T) ->
  receive
  after T ->
    true
  end.