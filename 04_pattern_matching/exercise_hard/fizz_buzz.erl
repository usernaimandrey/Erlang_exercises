%% Реализовать Fizz Buzz
%% https://habr.com/ru/post/298134/

-module(fizz_buzz).

-export([fizz_buzz/0]).

-include_lib("eunit/include/eunit.hrl").



fizz_buzz_by_number(Number) ->
  IsDiveidebleByThree = Number rem 3 =:= 0,
  IsDiveidebleByFive = Number rem 5 =:= 0,
  if
    IsDiveidebleByFive andalso IsDiveidebleByThree -> fizzbuzz;
    IsDiveidebleByThree -> fizz;
    IsDiveidebleByFive -> buzz;
    true -> Number
  end.

fizz_buzz_print(Res) ->
  io:format("~p~n", [Res]).

fizz_buzz() ->
  Seq = lists:seq(1, 100),
  lists:foreach(fun(N) -> fizz_buzz_print(fizz_buzz_by_number(N)) end, Seq).


fizz_buzz_by_number_test() ->
  ?assertEqual(fizz, fizz_buzz_by_number(6)),
  ?assertEqual(buzz, fizz_buzz_by_number(5)),
  ?assertEqual(fizzbuzz, fizz_buzz_by_number(15)),
  ?assertEqual(7, fizz_buzz_by_number(7)),
  ok.

