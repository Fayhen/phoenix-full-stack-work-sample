defmodule FlyWeb.AppLive.Show do
  use FlyWeb, :live_view
  require Logger

  alias Fly.Client
  alias FlyWeb.Components.AppDetailNavigation
  alias FlyWeb.Components.HeaderBreadcrumbs

  @impl true
  def mount(%{"name" => name}, session, socket) do
    socket =
      assign(socket,
        config: client_config(session),
        state: :loading,
        app: nil,
        app_name: name,
        count: 0,
        authenticated: true,
        render_components: "overview",
        show_hardware: "hidden",
        show_backup_regions: "hidden",
        show_region_scaling: "hidden"
      )

    # Only make the API call if the websocket is setup. Not on initial render.
    if connected?(socket) do
      {:ok, fetch_app(socket)}
    else
      {:ok, socket}
    end
  end

  defp client_config(session) do
    Fly.Client.config(access_token: session["auth_token"] || System.get_env("FLYIO_ACCESS_TOKEN"))
  end

  defp fetch_app(socket) do
    app_name = socket.assigns.app_name

    case Client.fetch_app(app_name, socket.assigns.config) do
      {:ok, app} ->
        assign(socket, :app, app)

      {:error, :unauthorized} ->
        put_flash(socket, :error, "Not authenticated")

      {:error, reason} ->
        Logger.error("Failed to load app '#{inspect(app_name)}'. Reason: #{inspect(reason)}")

        put_flash(socket, :error, reason)
    end
  end

  @impl true
  def handle_event("render_components", component_group, socket) do
    group = component_group["group"]
    cond do
      group == "overview" ->
        {:noreply, assign(socket, render_components: "overview")}
      group == "autoscaling" ->
        {:noreply, assign(socket, render_components: "autoscaling")}
      group == "processes" ->
        {:noreply, assign(socket, render_components: "processes")}
      group == "timeline" ->
        {:noreply, assign(socket, render_components: "timeline")}
      true ->
        {:noreply, assign(socket, render_components: "overview")}
    end
  end

  @impl true
  def handle_event("click", _params, socket) do
    {:noreply, assign(socket, count: socket.assigns.count + 1)}
  end

  @impl true
  def handle_info({:toggle_show_hardware, updated}, socket) do
    {:noreply, assign(socket, :show_hardware, updated)}
  end

  @impl true
  def handle_info({:toggle_show_backup_regions, updated}, socket) do
    {:noreply, assign(socket, :show_backup_regions, updated)}
  end

  @impl true
  def handle_info({:toggle_show_region_scaling, updated}, socket) do
    {:noreply, assign(socket, :show_region_scaling, updated)}
  end

  def status_bg_color(app) do
    case app["status"] do
      "running" -> "bg-green-100"
      "dead" -> "bg-red-100"
      _ -> "bg-yellow-100"
    end
  end

  def status_text_color(app) do
    case app["status"] do
      "running" -> "text-green-800"
      "dead" -> "text-red-800"
      _ -> "text-yellow-800"
    end
  end

  def preview_url(app) do
    "https://#{app["name"]}.fly.dev"
  end
end
