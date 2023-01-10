defmodule ExCom.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ExComWeb.Telemetry,
      # Start the Ecto repository
      ExCom.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ExCom.PubSub},
      # Start Finch
      {Finch, name: ExCom.Finch},
      # Start the Endpoint (http/https)
      ExComWeb.Endpoint
      # Start a worker by calling: ExCom.Worker.start_link(arg)
      # {ExCom.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExCom.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExComWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
