-module(test).

-export([run/0, run/1]).

run() ->
    Module = group_by_implimentation,
    Res = eunit:test(Module),
    case Res of
        ok -> init:stop(0);
        _ -> init:stop(1)
    end.

run([M, F]) ->
    io:format("run test ~p:~p~n", [M, F]),
    try erlang:apply(M, F, []) of
        ok -> 
            io:format("result: ok~n~n"),
            init:stop(0);
        Res -> 
            io:format("result: ~p~n~n", [Res]),
            init:stop(0)
    catch
        Class:Reason:Stacktrace ->
            io:format("test FAILED!~n~p:~p~n~p~n~n", [Class, Reason, Stacktrace]),
            init:stop(1)
    end.

