# ExUptimerobot

A small Elixir wrapper for the https://uptimerobot.com/ API service. Currently
very much WIP with very limited functionality.


## Usage

Configure with your Uptime Robot API key:

```elixir
config :ex_uptimerobot, :api_key, "your-uptimerobot-api-key"
```

Example usage:
- Get all monitors: `ExUptimerobot.Monitor.get_monitors()`
- Add new monitor: `ExUptimerobot.Monitor.new_monitor("Elixir Lang", "http://elixir-lang.org/")`


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_uptimerobot` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ex_uptimerobot, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/uptimerobot](https://hexdocs.pm/uptimerobot).

