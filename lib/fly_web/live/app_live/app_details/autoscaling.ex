defmodule FlyWeb.AppLive.Autoscaling do
  use FlyWeb, :live_component
  require Logger

  def mount(%{"name" => _name}, session, socket) do
    socket =
      assign(socket,
        config: client_config(session),
        state: :loading,
        authenticated: true,
        autoscaling: nil,
        show_region_scaling: "hidden"
      )

    {:ok, socket}
  end

  defp client_config(session) do
    Fly.Client.config(access_token: session["auth_token"] || System.get_env("FLYIO_ACCESS_TOKEN"))
  end

  @impl true
  def handle_event("toggle_show_region_scaling", _params, socket) do
    updated = if socket.assigns.show_region_scaling == "hidden" do
      "grid grid-cols-3 gap-y-3 text-center"
    else
      "hidden"
    end
    send self(), {:toggle_show_region_scaling, updated}
    {:noreply, socket}
  end

  def describe_scaling_strategy(strategy) do
    cond do
      strategy == "PREFERRED_REGIONS" ->
        "Scale in preferred regions by weight"
      strategy == "CONNECTION_SOURCES" ->
        "Scale in regions near connection sources"
      strategy == "NONE" ->
        "Autoscaling is disabled"
      true ->
        "Not configured"
    end
  end
end
