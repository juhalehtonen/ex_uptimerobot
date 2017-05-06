use Mix.Config

if Mix.env == :dev || Mix.env == :test do
  import_config "secret.exs"
end