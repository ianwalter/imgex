defmodule Imgex.Mixfile do
  use Mix.Project

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Ian Walter"],
      licenses: ["ISC"],
      links: %{
        "GitLab" => "https://gitlab.recursive.run/ianwalter/imgex",
        "GitHub" => "https://github.com/ianwalter/imgex"
      }
    ]
  end

  defp description do
    """
    An Elixir client library for generating image URLs with imgix
    """
  end

  def project do
    [
      app: :imgex,
      version: "0.2.0",
      elixir: "~> 1.1",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
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
