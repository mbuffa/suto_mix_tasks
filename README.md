# SutoMixTasks

Contains some Mix Tasks used for the Suto project.

Having them in a separate dependency helps with tracking their own dependencies. This may be useful when upgrading to Phoenix 1.8+.

- `suto.gen.live` generates the same files as `phx.gen.live`, but with Petal components. Templates are based on Phoenix 1.6 templates updated for Phoenix 1.7 and Petal Components.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `suto_mix_tasks` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:suto_mix_tasks, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/suto_mix_tasks>.
