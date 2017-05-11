# ExUptimerobot

[![Build Status](https://travis-ci.org/juhalehtonen/ex_uptimerobot.svg?branch=master)](https://travis-ci.org/juhalehtonen/ex_uptimerobot)

A small Elixir wrapper for the https://uptimerobot.com/ API (v2) service.

Note that this library is still under construction and in major version zero, and thus not all functionality offered by the Uptime Robot API is yet present. See the docs at [https://hexdocs.pm/ex_uptimerobot](https://hexdocs.pm/ex_uptimerobot) to see what's available at this time.

## Installation

1. Add `ex_uptimerobot` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ex_uptimerobot, "~> 0.3.0"}]
end
```

2. Run `mix deps.get`

Configure with your Uptime Robot API key, either via:

```elixir
config :ex_uptimerobot, :api_key, "your-uptimerobot-api-key"
```

or by setting the `EXUPTIMEROBOT_API_KEY` system environment variable.

## Using ExUptimerobot

Example usage:

- Get all monitors: `ExUptimerobot.Monitor.get_monitors()`
- Add a new monitor: `ExUptimerobot.Monitor.new_monitor([friendly_name: "Elixir Lang", url: "http://elixir-lang.org/", type: 1])`
- Get account details: `ExUptimerobot.Account.get_account_details()`
- Get all alert contacts: `ExUptimerobot.AlertContact.get_alert_contacts()`

## Documentation

Docs can be found at [https://hexdocs.pm/ex_uptimerobot](https://hexdocs.pm/ex_uptimerobot).

## Testing

- ExUnit: `mix test`
- Dialyzer: `mix dialyzer`
- Coveralls: `mix coveralls`
- Credo: `mix credo --strict`

## License

Made available under the MIT license. See [LICENSE](LICENSE.md) for more details.
