import Combine
import Foundation
@testable import Github

final class GithubServiceMock {
    // MARK: - Properties

    var repositoriesResult: Result<[RepositoryDTO], Error>?
    var repositoryDetailsResult: Result<RepositoryDTO, Error>?
    var commitsResult: Result<[CommitDTO], Swift.Error>?
}

// MARK: - GithubServiceProtocol

extension GithubServiceMock: GithubServiceProtocol {
    func fetchRepositories() -> AnyPublisher<[RepositoryDTO], Error> {
        switch repositoriesResult {
        case let .success(repositories):
            return AnyPublisher<[RepositoryDTO], Error>(Result<[RepositoryDTO], Error>.Publisher(repositories))
        case let .failure(error):
            return Fail(error: error).eraseToAnyPublisher()
        case .none:
            return Fail(error: GithubService.Error.invalidURL).eraseToAnyPublisher()
        }
    }

    func fetchRepository(model _: Endpoint.DetailsModel) -> AnyPublisher<RepositoryDTO, Error> {
        switch repositoryDetailsResult {
        case let .success(repository):
            return AnyPublisher<RepositoryDTO, Error>(Result<RepositoryDTO, Error>.Publisher(repository))
        case let .failure(error):
            return Fail(error: error).eraseToAnyPublisher()
        case .none:
            return Fail(error: GithubService.Error.invalidURL).eraseToAnyPublisher()
        }
    }

    func fetchCommits(model _: Endpoint.DetailsModel) -> AnyPublisher<[CommitDTO], Error> {
        switch commitsResult {
        case let .success(commits):
            return AnyPublisher<[CommitDTO], Error>(Result<[CommitDTO], Error>.Publisher(commits))
        case let .failure(error):
            return Fail(error: error).eraseToAnyPublisher()
        case .none:
            return Fail(error: GithubService.Error.invalidURL).eraseToAnyPublisher()
        }
    }
}
