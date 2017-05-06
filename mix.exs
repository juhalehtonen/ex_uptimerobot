defmodule ExUptimerobot.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_uptimerobot,
     version: "0.2.1",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     description: description(),
     package: package()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Defining the package for Hex.pm
  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["Juha Lehtonen"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/juhalehtonen/ex_uptimerobot"}
    ]
  end

  defp description do
    """
    A simple Elixir wrapper for the Uptime Robot API.
    """
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
     {:poison, "~> 3.1"},
     {:httpoison, "~> 0.11.2"},
     {:ex_doc, "~> 0.15.1", only: :dev, runtime: false},
     {:earmark, "~> 1.2", only: :dev}
    ]
  end
end
