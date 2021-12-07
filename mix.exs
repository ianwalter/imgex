defmodule Imgex.Mixfile do
  use Mix.Project

  @github_url "https://github.com/ianwalter/imgex"
  @version "0.3.0"

  defp package do
    [
      description: "An Elixir client library for generating image URLs with imgix",
      files: ["lib", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["Ian Walter"],
      licenses: ["ISC"],
      links: %{
        "GitHub" => @github_url
      }
    ]
  end

  def project do
    [
      app: :imgex,
      version: @version,
      elixir: "~> 1.5",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      extras: [
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @github_url,
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end
end
