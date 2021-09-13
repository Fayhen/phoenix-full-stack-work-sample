defmodule FlyWeb.Components.AppDetailNavigation do
  use Phoenix.Component
  use Phoenix.HTML

  def render(assigns) do
    button_display_classes =
      case assigns.display_mode do
        "header" -> "hidden sm:flex sm:flex-col sm:items-center"
        "footer" -> "flex flex-col items-center justify-center"
      end
    ~H"""
    <nav class="mx-6 h-16 w-screen sm:w-4/5 text-gray-400 flex justify-around sm:items-center">
      <!-- Toggle overview components -->
      <div class={"hover:text-gray-500 #{button_display_classes} cursor-pointer"} phx-click="render_components" phx-value-group="overview">
        <div class="h-10 w-10 flex items-center justify-center hover:bg-gray-700 rounded-full">
          <!-- Heroicon name: globe -->
          <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9a9 9 0 01-9-9m9 9c1.657 0 3-4.03 3-9s-1.343-9-3-9m0 18c-1.657 0-3-4.03-3-9s1.343-9 3-9m-9 9a9 9 0 019-9" />
          </svg>
        </div>
        <span class="font-semibold text-xs">Overview</span>
      </div>

      <!-- Toggle autoscaling components -->
      <div class={"hover:text-gray-500 #{button_display_classes} cursor-pointer"} phx-click="render_components" phx-value-group="autoscaling">
        <div class="h-10 w-10 flex items-center justify-center hover:bg-gray-700 rounded-full">
          <!-- Heroicon name: trending-up -->
          <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
          </svg>
        </div>
        <span class="font-semibold text-xs">Autoscaling</span>
      </div>

      <!-- Toggle processes components -->
      <div class={"hover:text-gray-500 #{button_display_classes} cursor-pointer"} phx-click="render_components" phx-value-group="processes">
        <div class="h-10 w-10 flex items-center justify-center hover:bg-gray-700 rounded-full">
          <!-- Heroicon name: collection -->
          <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
          </svg>
        </div>
        <span class="font-semibold text-xs">Processes</span>
      </div>

      <!-- Toggle history components -->
      <div class={"hover:text-gray-500 #{button_display_classes} cursor-pointer"} phx-click="render_components" phx-value-group="timeline">
        <div class="h-10 w-10 flex items-center justify-center hover:bg-gray-700 rounded-full">
          <!-- Heroicon name: clock -->
          <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
          </svg>
        </div>
        <span class="font-semibold text-xs">History</span>
      </div>

      <!-- Logout button -->
      <%= if @show_logout_button == true do %>
        <div class="ml-auto sm:ml-0 hover:text-gray-500">
          <%= link to: @logout_link, method: :delete,
            class: "whitespace-nowrap text-base font-medium" do %>
            <div class="flex flex-col items-center">
              <div class="h-10 w-10 flex items-center justify-center hover:bg-gray-700 rounded-full cursor-pointer">
                <!-- Heroicon name: logout -->
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                </svg>
              </div>
              <span class="font-semibold text-xs">Sign Out</span>
            </div>
          <% end %>
        </div>
      <% end %>
    </nav>
    """
  end
end
