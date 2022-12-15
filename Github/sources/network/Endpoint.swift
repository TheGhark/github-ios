import Foundation

enum Endpoint {
    // MARK: - Types

    struct DetailsModel {
        let name: String
        let owner: String
    }

    // MARK: - Properties

    private static let api = "https://api.github.com"

    // MARK: - Cases

    case repositories
    case repositoryDetails(model: DetailsModel)

    // MARK: - Computed Properties

    var components: URLComponents? {
        guard var components = URLComponents(string: Self.api) else {
            return nil
        }

        switch self {
        case .repositories:
            components.path = "/user/repos"
        case let .repositoryDetails(model):
            components.path = "/repos/\(model.owner)/\(model.name)"
        }

        return components
    }
}
