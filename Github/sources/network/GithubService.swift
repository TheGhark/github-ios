import Foundation
import Combine

protocol GithubServiceProtocol {
    func fetchRepositories() -> AnyPublisher<[RepositoryDTO], Swift.Error>
    func fetchRepository(model: Endpoint.DetailsModel) -> AnyPublisher<RepositoryDTO, Swift.Error>
    func fetchCommits(model: Endpoint.DetailsModel) -> AnyPublisher<[CommitDTO], Swift.Error>
}

final class GithubService {
    // MARK: - Types

    enum Error: Swift.Error {
        case invalidURL
        case failedRequest
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

    func fetchRepository(model: Endpoint.DetailsModel) -> AnyPublisher<RepositoryDTO, Swift.Error> {
        do {
            let request = try URLRequest(endpoint: .repositoryDetails(model: model))
            return session.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: RepositoryDTO.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }

    func fetchCommits(model: Endpoint.DetailsModel) -> AnyPublisher<[CommitDTO], Swift.Error> {
        do {
            let request = try URLRequest(endpoint: .commits(model: model))
            return session.dataTaskPublisher(for: request)
                .tryMap { (data: Data, response: URLResponse) in
                    guard
                        let response = response as? HTTPURLResponse,
                        (200..<300).contains(response.statusCode)
                    else {
                        throw Error.failedRequest
                    }

                    return data
                }
                .decode(type: [CommitDTO].self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
