# Rebar 3 Umbrella Example

This is an example of using Rebar 3 with an umbrella project.

App `foo` depends on → App `bar` which depends on → `hackney` from Hex.

## Questions

1. Why does `rebar3 ct --suite ...` in the root directory fail to find the
  `foo_SUITE` test?
2. Why can't tasks in `foo` find the dependency `bar`?
2. How is one supposed to declare dependencies between umbrella apps?

## In Root

<details><summary>✅ All Tests</summary>

```console
$ rebar3 ct
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling bar
===> Compiling foo
===> Running Common Test suites...
%%% bar_SUITE: .
%%% foo_SUITE: .
All 2 tests passed.
```

</details>

<details><summary>❌ Single Test</summary>

```console
$ rebar3 ct --suite foo_SUITE
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling bar
===> Compiling foo
===> Analyzing applications...
===> Compiling extra_/private/tmp/foo/_build/test/extras
===> Running Common Test suites...
Suite foo_SUITE not found in directory /private/tmp/foo/_build/test/extras
===> Error running tests:
  {make_failed,["/private/tmp/foo/_build/test/extras/foo_SUITE"]}
```

</details>

<details><summary>✅ Shell</summary>

```console
$ rebar3 shell --apps foo
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling bar
===> Compiling foo
Erlang/OTP 26 [erts-14.0.1] [source] [64-bit] [smp:12:12] [ds:12:12:10] [async-threads:1] [jit]

Eshell V14.0.1 (press Ctrl+G to abort, type help(). for help)
1> ===> Booted unicode_util_compat
===> Booted idna
===> Booted mimerl
===> Booted certifi
===> Booted syntax_tools
===> Booted parse_trans
===> Booted ssl_verify_fun
===> Booted metrics
===> Booted hackney
===> Booted bar
===> Booted foo
```

</details>

## In Foo

<details><summary>❌ All Tests</summary>

```console
$ cd apps/foo
$ rebar3 ct
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling foo
===> Running Common Test suites...
%%% foo_SUITE:
%%% foo_SUITE ==> test: FAILED
%%% foo_SUITE ==> {{badmatch,{error,{bar,{"no such file or directory","bar.app"}}}},
 [{foo_SUITE,test,1,
             [{file,"/private/tmp/foo/apps/foo/test/foo_SUITE.erl"},
              {line,12}]},
  {test_server,ts_tc,3,[{file,"test_server.erl"},{line,1782}]},
  {test_server,run_test_case_eval1,6,[{file,"test_server.erl"},{line,1291}]},
  {test_server,run_test_case_eval,9,[{file,"test_server.erl"},{line,1223}]}]}

EXPERIMENTAL: Writing retry specification at /private/tmp/foo/apps/foo/_build/test/logs/retry.spec
              call rebar3 ct with '--retry' to re-run failing cases.
Failed 1 tests. Passed 0 tests.
Results written to "/private/tmp/foo/apps/foo/_build/test/logs/index.html".
===> Failures occurred running tests: 1
```

</details>

<details><summary>❌ Single Test</summary>

```console
$ rebar3 ct --suite foo_SUITE
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling foo
===> Running Common Test suites...
%%% foo_SUITE:
%%% foo_SUITE ==> test: FAILED
%%% foo_SUITE ==> {{badmatch,{error,{bar,{"no such file or directory","bar.app"}}}},
 [{foo_SUITE,test,1,
             [{file,"/private/tmp/foo/apps/foo/test/foo_SUITE.erl"},
              {line,12}]},
  {test_server,ts_tc,3,[{file,"test_server.erl"},{line,1782}]},
  {test_server,run_test_case_eval1,6,[{file,"test_server.erl"},{line,1291}]},
  {test_server,run_test_case_eval,9,[{file,"test_server.erl"},{line,1223}]}]}

EXPERIMENTAL: Writing retry specification at /private/tmp/foo/apps/foo/_build/test/logs/retry.spec
              call rebar3 ct with '--retry' to re-run failing cases.
Failed 1 tests. Passed 0 tests.
Results written to "/private/tmp/foo/apps/foo/_build/test/logs/index.html".
===> Failures occurred running tests: 1
```

</details>

<details><summary>❌ Shell</summary>

```console
$ cd apps/foo
$ rebar3 shell --apps foo
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling foo
Erlang/OTP 26 [erts-14.0.1] [source] [64-bit] [smp:12:12] [ds:12:12:10] [async-threads:1] [jit]

Eshell V14.0.1 (press Ctrl+G to abort, type help(). for help)
1> ===> Failed to boot bar for reason {"no such file or directory",
                                               "bar.app"}
```

</details>

## In Bar

<details><summary>✅ All Tests</summary>

```console
$ cd apps/bar
$ rebar3 ct
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling bar
===> Running Common Test suites...
%%% bar_SUITE: .
All 1 tests passed.
```

</details>

<details><summary>✅ Single Test</summary>

```console
$ rebar3 ct --suite bar_SUITE
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling bar
===> Running Common Test suites...
%%% bar_SUITE: .
All 1 tests passed.
```

</details>

<details><summary>✅ Shell</summary>

```console
$ cd apps/bar
$ rebar3 shell --apps bar
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling bar
Erlang/OTP 26 [erts-14.0.1] [source] [64-bit] [smp:12:12] [ds:12:12:10] [async-threads:1] [jit]

Eshell V14.0.1 (press Ctrl+G to abort, type help(). for help)
1> ===> Booted unicode_util_compat
===> Booted idna
===> Booted mimerl
===> Booted certifi
===> Booted syntax_tools
===> Booted parse_trans
===> Booted ssl_verify_fun
===> Booted metrics
===> Booted hackney
===> Booted bar
```

</details>
