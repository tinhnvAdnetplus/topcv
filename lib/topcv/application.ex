defmodule Topcv.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TopcvWeb.Telemetry,
      Topcv.Repo,
      {DNSCluster, query: Application.get_env(:topcv, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Topcv.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Topcv.Finch},
      # Start a worker by calling: Topcv.Worker.start_link(arg)
      # {Topcv.Worker, arg},
      # Start to serve requests, typically the last entry
      TopcvWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Topcv.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TopcvWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
