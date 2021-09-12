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

  def get_image_status(image_src) do
    status = Fly.Utils.verify_response_status_code(image_src)
    status in [200, 304]
  end
end
