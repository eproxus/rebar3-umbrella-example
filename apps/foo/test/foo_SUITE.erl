-module(foo_SUITE).

% Tests
-export([all/0]).
-export([test/1]).

%--- Tests ---------------------------------------------------------------------

all() -> [test].

test(_Config) ->
    {ok, _} = application:ensure_all_started(foo).
