defmodule Imgex.Mixfile do
  use Mix.Project

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Ian Walter"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ianwalter/imgex"}
    ]
  end

  defp description do
    """
    Unofficial client library for generating imgix URLs in Elixir
    """
  end

  def project do
    [
      app: :imgex,
      version: "0.1.0",
      elixir: "~> 1.1",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.10", only: :dev}
    ]
  end
end
