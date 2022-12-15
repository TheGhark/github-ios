import Foundation
import Combine

protocol GithubRepositoryProtocol {
    func fetchRepositories() -> AnyPublisher<[Repository], Swift.Error>
    func fetchRepository(model: Endpoint.DetailsModel) -> AnyPublisher<Repository, Swift.Error>
    func fetchCommits(model: Endpoint.DetailsModel) -> AnyPublisher<[Commit], Swift.Error>
}

final class GithubRepository {
    // MARK: - Properties

    private let dateFormatter: DateFormatter
    private let service: GithubServiceProtocol

    // MARK: - Initialization

    init(dateFormatter: DateFormatter = .iso,
        service: GithubServiceProtocol = GithubService()) {
        self.dateFormatter = dateFormatter
        self.service = service
    }
}

// MARK: - GithubRepositoryProtocol

extension GithubRepository: GithubRepositoryProtocol {
    func fetchRepositories() -> AnyPublisher<[Repository], Swift.Error> {
        service.fetchRepositories()
            .map { dtos in
                dtos.map { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }
    func fetchRepository(model: Endpoint.DetailsModel) -> AnyPublisher<Repository, Swift.Error> {
        service.fetchRepository(model: model)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }

    func fetchCommits(model: Endpoint.DetailsModel) -> AnyPublisher<[Commit], Swift.Error> {
        service.fetchCommits(model: model)
            .map { dtos in
                dtos.compactMap { try? $0.toDomain(with: self.dateFormatter) }
            }
            .eraseToAnyPublisher()
    }
}
