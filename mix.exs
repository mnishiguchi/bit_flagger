defmodule BitFlagger.MixProject do
  use Mix.Project

  @version "0.1.1"
  @source_url "https://github.com/mnishiguchi/bit_flagger"

  def project do
    [
      app: :bit_flagger,
      version: @version,
      description: "Manipulate bit flags in Elixir",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      aliases: [],
      dialyzer: dialyzer(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.24", only: [:dev], runtime: false},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false}
    ]
  end

  defp dialyzer() do
    [
      flags: [:race_conditions, :unmatched_returns, :error_handling, :underspecs]
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end

  defp package do
    %{
      files: [
        "lib",
        "mix.exs",
        "README.md",
        "LICENSE*",
        "CHANGELOG*"
      ],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url
      }
    }
  end
end
