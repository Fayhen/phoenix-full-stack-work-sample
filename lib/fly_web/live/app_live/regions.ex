defmodule FlyWeb.AppLive.Regions do
  use FlyWeb, :live_component

  def mount(%{"name" => _name}, session, socket) do
    socket =
      assign(socket,
        config: client_config(session),
        state: :loading,
        authenticated: true,
        regions: nil,
        backup_regions: nil,
        show_backup_regions: "hidden"
      )

    {:ok, socket}
  end

  defp client_config(session) do
    Fly.Client.config(access_token: session["auth_token"] || System.get_env("FLYIO_ACCESS_TOKEN"))
  end

  @impl true
  def handle_event("toggle_show_backup_regions", _params, socket) do
    updated = if socket.assigns.show_backup_regions == "hidden" do
      "flex flex-col"
    else
      "hidden"
    end
    send self(), {:toggle_show_backup_regions, updated}
    {:noreply, socket}
  end
end
