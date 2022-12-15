import Combine
import Foundation
@testable import Github
import XCTest

final class GithubRepositoryTests: XCTestCase {
    var sut: GithubRepositoryProtocol!
    var service: GithubServiceMock!
    var subscriptions: [AnyCancellable] = []

    override func setUp() {
        super.setUp()

        service = .init()
        sut = GithubRepository(service: service)
    }

    override func tearDown() {
        service = nil
        sut = nil
        super.tearDown()
    }

    func testFetchRepositoriesSuccess() {
        let dtos: [RepositoryDTO] = [.sample()]
        let expected: [Repository] = dtos.map { $0.toDomain() }
        let expectation = self.expectation(description: #function)
        service.repositoriesResult = .success(dtos)
        sut.fetchRepositories()
            .map { $0 }
            .sink { completion in
                expectation.fulfill()
                switch completion {
                case let .failure(error):
                    XCTFail("The request should have succeeded. Failed with error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { repositories in
                XCTAssertEqual(repositories, expected)
            }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 1)
    }

    func testFetchRepositoriesFailure() {
        let expected = GithubService.Error.failedRequest
        let expectation = self.expectation(description: #function)
        service.repositoriesResult = .failure(expected)
        sut.fetchRepositories()
            .mapError { $0 }
            .sink { completion in
                expectation.fulfill()
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error.localizedDescription, expected.localizedDescription)
                case .finished:
                    XCTFail("The request should have failed")
                }
            } receiveValue: { _ in }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 1)
    }

    func testFetchRepositoryDetailsSuccess() {
        let dto = RepositoryDTO.sample()
        let expected = dto.toDomain()
        let expectation = self.expectation(description: #function)
        service.repositoryDetailsResult = .success(dto)
        sut.fetchRepository(model: .init(name: dto.name, owner: dto.owner.login))
            .map { $0 }
            .sink { completion in
                expectation.fulfill()
                switch completion {
                case let .failure(error):
                    XCTFail("The request should have succeeded. Failed with error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { repository in
                XCTAssertEqual(repository, expected)
            }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 1)
    }

    func testFetchRepositoryDetailsFailure() {
        let expected = GithubService.Error.failedRequest
        let expectation = self.expectation(description: #function)
        service.repositoryDetailsResult = .failure(expected)
        sut.fetchRepository(model: .init(name: "name", owner: "login"))
            .mapError { $0 }
            .sink { completion in
                expectation.fulfill()
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error.localizedDescription, expected.localizedDescription)
                case .finished:
                    XCTFail("The request should have failed")
                }
            } receiveValue: { _ in }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 1)
    }

    func testFetchCommitsSuccess() {
        let dtos: [CommitDTO] = [.sample()]
        let expected = dtos.compactMap { try? $0.toDomain(with: .init()) }
        let expectation = self.expectation(description: #function)
        service.commitsResult = .success(dtos)
        sut.fetchCommits(model: .init(name: "venues", owner: "TheGhark"))
            .map { $0 }
            .sink { completion in
                expectation.fulfill()
                switch completion {
                case let .failure(error):
                    XCTFail("The request should have succeeded. Failed with error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { commits in
                XCTAssertEqual(commits, expected)
            }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 1)
    }

    func testFetchCommitsFailure() {
        let expected = GithubService.Error.failedRequest
        let expectation = self.expectation(description: #function)
        service.commitsResult = .failure(expected)
        sut.fetchCommits(model: .init(name: "name", owner: "login"))
            .mapError { $0 }
            .sink { completion in
                expectation.fulfill()
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error.localizedDescription, expected.localizedDescription)
                case .finished:
                    XCTFail("The request should have failed")
                }
            } receiveValue: { _ in }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 1)
    }
}
