%% Реализовать функцию, которая принимает список, и возвращает максимальный элемент этого списка

-module(list_max).

-export([list_max/1]).

-include_lib("eunit/include/eunit.hrl").


list_max(List) -> 
  F = fun(Element, Acc) ->
        if 
          Element > Acc -> Element;
          true -> Acc
        end
      end,
  IsZero = is_zero(length(List)), 
  if
    IsZero -> 0;
    true ->
      [H | _] = List,
      lists:foldl(F, H, List)
  end.

is_zero(Num) ->
  Num =:= 0.

list_max_test() ->
  ?assertEqual(0, list_max([])),
  ?assertEqual(1, list_max([1])),
  ?assertEqual(-1, list_max([-1])),
  ?assertEqual(-2, list_max([-3, -2, -6])),
  ?assertEqual(3, list_max([1, 2, 3])).

