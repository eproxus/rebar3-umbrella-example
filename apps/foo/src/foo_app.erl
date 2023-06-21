%%%-------------------------------------------------------------------
%% @doc foo public API
%% @end
%%%-------------------------------------------------------------------

-module(foo_app).

-include_lib("hackney/include/hackney.hrl").

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    foo_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
