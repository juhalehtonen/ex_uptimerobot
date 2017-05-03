use Mix.Config

if Mix.env == :dev do
  import_config "secret.exs"
end