This fork is this author's take on building a custom dynamic dashboard for apps deployed to [Fly.io](Fly.io), using [Phoenix Framework](https://phoenixframework.org/)'s LiveView components. It uses Fly's GraphQL API to fetch live data from an authenticated user's deployed applications and displays it in dedicated views. The starter template can be found at the original [phoenix-full-stack-work-sample](https://github.com/fly-hiring/phoenix-full-stack-work-sample) repository.

### What has been built

The starter dashboard was transformed into a new responsive view containing a wider variety of information for deployed applications. This data is distributed among a plethora of dedicated live components, that are organized within different tabs in the main app details page. The retrieved app data currently consists of:

- General status information, deployed regions and IP addresses, found within the `Overview` tab.
- Current autoscaling configuration for the app, within the `Autoscaling` tab.
- Process groups details and running services, within the `Processes` tab.
- A timeline of past activity for the app, within the `History` tab.

Changes were made in different places to reach the results summarized above:

- The GraphQL query string fo retrieving app data was updated with additional fields. The reasoning for selecting which data to be retrieved took a user-oriented approach, choosing which of the available app information would be more frequently browsed by users.
- A plethora of new live components were created and nested within the app details view, each with a dedicated set of data to display.
- A few helper functions were added. In general, they toggle different CSS classes within templates. There is also a datetime string formatter.
- Due to an issue with user profile picture URLs being returned from the API, a validator was created. It checks the status response from attempting to request the picture (using HTTPoison). Its return value can be used to conditionally render either pictures with successful requests or placeholders.

### What has not been built

The dashboard currently has only browsing functionality. That means it only shows data from deployed apps, but cannot modify it (e.g., changing settings, restarting apps, redeploying, showing logs). A future version can be integrated with different Fly API endpoints for a fully functional admin dashboard.

### What can be improved with time

Besides full administrational capabilities as detailed in the section above, below are a few aspects that can be improved in the dashboard on its current version:

- Router integration for the different app information tabs. The current version works through simple toggling of CSS classes. Nested routes with dedicated queries can reduce server overload by requesting less, more scoped data at a time, as well as proving proper programmatic navigation.
- Expanding the variety of retrieved app data, nesting it accordingly in new, dedicated components and tabs. Examples are certificates, app usage, logs, configuration, Postgres clusters and other fields available on the API.

### Closing notes

Building this dashboard has been a rich experience. The task yielded much new knowledge on both `flyctl` and LiveView's inner workings. The hands-on experience has greatly sparked this author's interest in Elixir and Phoenix, which now stands on high priority in his must-code list, with a few personal experiments already taking form. Further, the experience of using `flyctl` for app deployment was easy and enjoyable, as few others in personal experience have been. It became a personal recommendation for deploying projects.
