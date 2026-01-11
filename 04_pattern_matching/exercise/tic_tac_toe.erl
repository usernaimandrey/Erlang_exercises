-module(tic_tac_toe).

-export([new_game/0, win/1, move/3]).


new_game() ->
    {{f, f, f},
     {f, f, f},
     {f, f, f}}.

generate_win_combo({{A, B, C},
                   {D, E, F},
                   {G, H, I}}) ->
    [{A, B, C}, {D, E, F}, {G, H, I}, {A, D, G}, {B, E, H}, {C, F, I}, {G, E, C}, {A, E, I}].




check_win([]) -> no_win;
check_win([H | T]) ->
    case H of
        {x, x, x} -> {win, x};
        {o, o, o} -> {win, o};
        _ -> check_win(T)
    end.



win(GameState) ->
    check_win(generate_win_combo(GameState)).

normalize_cell(Cell) ->
    case Cell of
        X when X == 4 orelse X == 7 -> 1;
        X when X == 5 orelse X == 8 -> 2;
        X when X == 6 orelse X == 9 -> 3;
        _ -> Cell
    end.

get_row(Cell) ->
   Row1 = [1, 2, 3],
   Row2 = [4, 5, 6],
   Row3 = [7, 8, 9],
   IsRow1Member = lists:member(Cell, Row1),
   IsRow2Member = lists:member(Cell, Row2),
   IsRow3Member = lists:member(Cell, Row3),
   if
        IsRow1Member ->
            row_1;
        IsRow2Member ->
            row_2;
        IsRow3Member ->
            row_3;
        true -> not_found
    end.

check_element(Cell, GameState) ->
    NormalizeCell = normalize_cell(Cell),
    Row = get_row(Cell),
    Element = case Row of
        row_1 -> element(NormalizeCell, element(1, GameState));
        row_2 -> element(NormalizeCell, element(2, GameState));
        row_3 -> element(NormalizeCell, element(3, GameState));
        _ -> Row 
    end,
    Element == f.

set_element(Cell, Player, GameState) ->
    NormalizeCell = normalize_cell(Cell),
    Row = get_row(Cell),
    PositionAndElement = case Row of
        row_1 ->
            NewElement = setelement(NormalizeCell, element(1, GameState), Player),
            {1, NewElement};
        row_2 ->
            NewElement = setelement(NormalizeCell, element(2, GameState), Player),
            {2, NewElement};
        row_3 ->
            NewElement = setelement(NormalizeCell, element(3, GameState), Player),
            {3, NewElement}
    end,
    {Position, Element} = PositionAndElement,
    setelement(Position, GameState, Element).




move(Cell, Player, GameState) ->
    IsValidMove = check_element(Cell, GameState),
    case IsValidMove of
        true -> {ok, set_element(Cell, Player, GameState)};
        _ -> {error, invalid_move}
    end.
