-module(test).

-export([run/0, run/1]).

run() ->
    Module = fizz_buzz,
    Res = eunit:test(Module),
    case Res of
        ok -> init:stop(0);
        _ -> init:stop(1)
    end.


run([M, F]) ->
    io:format("run test ~p:~p~n", [M, F]),
    Res = erlang:apply(M, F, []),
    io:format("result: ~p~n~n", [Res]),
    case Res of
        ok -> init:stop(0);
        error -> init:stop(1)
    end.
