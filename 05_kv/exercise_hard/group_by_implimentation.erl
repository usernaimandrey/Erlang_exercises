-module(group_by_implimentation).

-export([group_by/2]).

-include_lib("eunit/include/eunit.hrl").

group_by(List, Fn) -> group_by(List, Fn, maps:new()).

group_by([], _Fn, Acc) -> maps:map(fun(_Key, List) -> lists:reverse(List) end, Acc);
group_by([Head | Tail], Fn, Acc) ->
    Key = Fn(Head),
    case get_value(Key, Acc) of
        {error, not_found} -> group_by(Tail, Fn, maps:put(Key, [Head], Acc));
        {ok, Group} -> group_by(Tail, Fn, maps:put(Key, [Head | Group], Acc))
    end.



get_value(Key, Acc) ->
    case Acc of
      #{Key := Val} -> {ok, Val};
      _ -> {error, not_found}
    end.


group_by_test() ->
  Data = [
    {user, "Bob", 21, male},
    {user, "Bill", 23, male},
    {user, "Helen", 17, female},
    {user, "Kate", 25, female},
    {user, "John", 20, male}
  ],
  Expected = #{
    female => [{user,"Helen",17,female},{user,"Kate",25,female}],
    male => [{user,"Bob",21,male}, {user,"Bill",23,male}, {user,"John",20,male}]
  },

  ?assertEqual(Expected, group_by(Data, fun({user, _, _, Gender}) -> Gender end)),
  ok.
