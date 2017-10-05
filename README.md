# ExUptimerobot

[![Build Status](https://travis-ci.org/juhalehtonen/ex_uptimerobot.svg?branch=master)](https://travis-ci.org/juhalehtonen/ex_uptimerobot)

A simple Elixir wrapper for the https://uptimerobot.com/ API (v2) service.

To use this library, see both [the official API documentation](https://uptimerobot.com/api) as well as the [ex_uptimerobot docs on Hexdocs](https://hexdocs.pm/ex_uptimerobot/api-reference.html).

## Installation

1. Add `ex_uptimerobot` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ex_uptimerobot, "~> 0.4.0"}]
end
```

2. Run `mix deps.get`

3. Configure with your Uptime Robot API key, either via:

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
