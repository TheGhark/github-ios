import Foundation

enum Endpoint {
    // MARK: - Types

    enum Error: Swift.Error {
        case invalidURL
        case invalidRepositoryDetails
    }

    struct DetailsModel {
        let name: String
        let owner: String

        var isValid: Bool {
            !name.isEmpty && !owner.isEmpty
        }
    }

    // MARK: - Properties

    private static let api = "https://api.github.com"

    // MARK: - Cases

    case repositories
    case repositoryDetails(model: DetailsModel)
    case commits(model: DetailsModel)

    // MARK: - Internal

    func urlComponents() throws -> URLComponents {
        guard var components = URLComponents(string: Self.api) else {
            throw Error.invalidURL
        }

        switch self {
        case .repositories:
            components.path = "/user/repos"
        case let .repositoryDetails(model):
            guard model.isValid else {
                throw Error.invalidRepositoryDetails
            }

            components.path = "/repos/\(model.owner)/\(model.name)"
        case let .commits(model):
            guard model.isValid else {
                throw Error.invalidRepositoryDetails
            }

            components.path = "/repos/\(model.owner)/\(model.name)/commits"
        }

        return components
    }
}
