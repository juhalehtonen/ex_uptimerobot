# ExUptimerobot

A small Elixir wrapper for the https://uptimerobot.com/ API service. Currently
very much WIP with very limited functionality.

## Installation

Add `ex_uptimerobot` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ex_uptimerobot, "~> 0.1.0"}]
end
```

Configure with your Uptime Robot API key:

```elixir
config :ex_uptimerobot, :api_key, "your-uptimerobot-api-key"
```

## Usage

Example usage:
- Get all monitors: `ExUptimerobot.Monitor.get_monitors()`
- Add a new monitor: `ExUptimerobot.Monitor.new_monitor("Elixir Lang", "http://elixir-lang.org/")`


## Documentation

Docs can be found at [https://hexdocs.pm/uptimerobot](https://hexdocs.pm/uptimerobot).

