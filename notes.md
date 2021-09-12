<!-- Note: These notes are currently a draft -->
Firstly, a deep dive into Fly.io's GraphQL API was taken, which provided detailed information on its schemas and on which data regarding deployed apps is available. The `fetch_app` query on the Client API was subsequently updated, increasing the amount of data being retrieved. The selected data set was devised taking a user-oriented approach, retrieving the most useful and readily understadable information to be displayed in the app details view.

Namely, the app details now includes:

  - A `General` section with current version, status, used resources and estimated pricing for the app.


---

A few utility variables were assigned to the Socket in `FlyWeb.AppLive.Show` for conditional rendering of UI elements.

A utility function to parse datetime strings on the `ISO 8601` format to the conventional `Month-Day-Year Hour:Minute` form was added to `Fly.Utils`. This function is used to parse dates in different templates, but perhaps a better, future approach would be to integrate date format parsing with internationalization libraries.

Upon compartmentalizing UI elements into live components, a single source of truth centralized in the parent LiveView was preferred. As such, a few booleans were assigned to its socket state. These booleans are toggled by handling events in the child components, then sending updated data values to `handle_info` functions in the parent.

<!-- CSS classes organization:
  [margin, padding, height, width] [typography] [position, display, flex/grid, spacing] [background] [borders, shadow] [cursor] -->
