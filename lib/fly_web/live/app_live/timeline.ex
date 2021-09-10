defmodule FlyWeb.AppLive.Timeline do
  use FlyWeb, :live_component

  def mount(%{"name" => _name}, session, socket) do
    socket =
      assign(socket,
        config: client_config(session),
        state: :loading,
        authenticated: true,
        releases: nil
      )

    {:ok, socket}
  end

  defp client_config(session) do
    Fly.Client.config(access_token: session["auth_token"] || System.get_env("FLYIO_ACCESS_TOKEN"))
  end
end
