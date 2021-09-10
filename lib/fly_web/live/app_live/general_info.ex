defmodule FlyWeb.AppLive.GeneralInfo do
  use FlyWeb, :live_component

  def mount(%{"name" => _name}, session, socket) do
    socket =
      assign(socket,
        config: client_config(session),
        state: :loading,
        authenticated: true,
        current_release: nil,
        vm_size: nil,
        show_hardware: "hidden"
      )

    {:ok, socket}
  end

  defp client_config(session) do
    Fly.Client.config(access_token: session["auth_token"] || System.get_env("FLYIO_ACCESS_TOKEN"))
  end

  @impl true
  def handle_event("toggle_show_hardware", _params, socket) do
    updated = if socket.assigns.show_hardware == "hidden" do
      "flex flex-col"
    else
      "hidden"
    end
    {:noreply, assign(socket, :show_hardware, updated)}
  end

  @impl true
  def handle_event("toggles_show_hardware", _params, socket) do
    updated = if socket.assigns.show_hardware == "hidden" do
      "flex flex-col"
    else
      "hidden"
    end
    send self(), {:toggle_show_hardware, updated}
    {:noreply, socket}
  end
end
