# Architecture

The app is divided into three layers: 1. Network 2. Repository 3. View

The network layer is responsible for fetching all the information needed from the Github repository:
- List of repositories
- Commits of a repository

The repository layer acts as the middle man between the network and the view layer. Additionally, it converts DTOs into domain objects.

The view layer follows the MVVM pattern for all the views, except for `LoadingView` and `ErrorView`

- Each repository displays the name, the owner, and the description if present
- Each commit contains the message, the author, the sha, and a relative date from now

Finally, there are tests covering the most important parts:
- `GithubServiceTests`: Tests all Github API calls. They call the service to make sure all DTOs are properly parsed
- `GithubRepositoryTests`: Tests all the calls done to the service
- `EndpointTests`: Tests that requests are created properly

All objects in the Repository and Network layer are fully mockable

# Improvements

- Pull to refresh in the repositories and commits view
- Session manager: Login and logout with email and password
- Display user information
- Search over the commits