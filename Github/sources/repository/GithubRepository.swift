import Combine
import Foundation

protocol GithubRepositoryProtocol {
    func fetchRepositories() -> AnyPublisher<[Repository], Swift.Error>
    func fetchRepository(model: Endpoint.DetailsModel) -> AnyPublisher<Repository, Swift.Error>
    func fetchCommits(model: Endpoint.DetailsModel) -> AnyPublisher<[Commit], Swift.Error>
}

final class GithubRepository {
    // MARK: - Properties

    private let dateFormatter: ISO8601DateFormatter
    private let service: GithubServiceProtocol

    // MARK: - Initialization

    init(dateFormatter: ISO8601DateFormatter = .init(),
         service: GithubServiceProtocol = GithubService()) {
        self.dateFormatter = dateFormatter
        self.service = service
    }
}

// MARK: - GithubRepositoryProtocol

extension GithubRepository: GithubRepositoryProtocol {
    func fetchRepositories() -> AnyPublisher<[Repository], Swift.Error> {
        service.fetchRepositories()
            .receive(on: RunLoop.main)
            .map { dtos in
                dtos.map { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }

    func fetchRepository(model: Endpoint.DetailsModel) -> AnyPublisher<Repository, Swift.Error> {
        service.fetchRepository(model: model)
            .receive(on: RunLoop.main)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }

    func fetchCommits(model: Endpoint.DetailsModel) -> AnyPublisher<[Commit], Swift.Error> {
        service.fetchCommits(model: model)
            .receive(on: RunLoop.main)
            .tryMap { dtos in
                var commits: [Commit] = []

                for dto in dtos {
                    let commit = try dto.toDomain(with: self.dateFormatter)
                    commits.append(commit)
                }

                return commits
            }
            .eraseToAnyPublisher()
    }
}
