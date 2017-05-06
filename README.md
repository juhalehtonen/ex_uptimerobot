# ExUptimerobot

A small Elixir wrapper for the https://uptimerobot.com/ API service. Currently
very much WIP with very limited functionality.

See [https://hexdocs.pm/uptimerobot](https://hexdocs.pm/uptimerobot) for a list 
of available API method wrappers.

## Installation

Add `ex_uptimerobot` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ex_uptimerobot, "~> 0.2.0"}]
end
```

Run `mix deps.get`

Configure with your Uptime Robot API key:

```elixir
config :ex_uptimerobot, :api_key, "your-uptimerobot-api-key"
```

## Usage

Example usage:
- Get all monitors: `ExUptimerobot.Monitor.get_monitors()`
- Add a new monitor: `ExUptimerobot.Monitor.new_monitor([friendly_name: "Elixir Lang", url: "http://elixir-lang.org/", type: 1])`


## Documentation

Docs can be found at [https://hexdocs.pm/uptimerobot](https://hexdocs.pm/uptimerobot).

## License

Made available under the MIT license. See [LICENSE](LICENSE.md) for more details.
