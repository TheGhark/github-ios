import Foundation
import Combine

protocol GithubServiceProtocol {
    func fetchRepositories() -> AnyPublisher<[RepositoryDTO], Swift.Error>
}

final class GithubService {
    // MARK: - Types

    enum Error: Swift.Error {
        case invalidURL
    }

    // MARK: - Properties

    private let session: URLSession

    // MARK: - Initialization

    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - GithubServiceProtocol

extension GithubService: GithubServiceProtocol {
    func fetchRepositories() -> AnyPublisher<[RepositoryDTO], Swift.Error> {
        do {
            let request = try URLRequest(endpoint: .repositories)
            return session.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: [RepositoryDTO].self, decoder: JSONDecoder())
                .eraseToAnyPublisher()

        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }

    }
}
