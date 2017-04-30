# Uptimerobot

A small Elixir API wrapper for the https://uptimerobot.com/ service. Currently
very much WIP with very limited functionality.


## Usage

Configure with your Uptime Robot API key:

```elixir
config :uptimerobot, :api_key, "your-uptimerobot-api-key"
```

Example usage:
- Get all monitors: `Uptimerobot.Monitor.get_monitors()`
- Add new monitor: `Uptimerobot.Monitor.new_monitor("Elixir Lang", "http://elixir-lang.org/", "1", "60")`


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `uptimerobot` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:uptimerobot, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/uptimerobot](https://hexdocs.pm/uptimerobot).

