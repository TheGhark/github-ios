import Combine
import Foundation
@testable import Github
import XCTest

final class GithubServiceTests: XCTestCase {
    var sut: GithubServiceProtocol!
    var subscriptions: [AnyCancellable] = []

    override func setUp() {
        super.setUp()
        sut = GithubService()
    }

    override func tearDown() {
        subscriptions.forEach { $0.cancel() }
        subscriptions = []
        sut = nil
        super.tearDown()
    }

    func testFetchRepositoriesSuccess() {
        let expectation = self.expectation(description: #function)
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
            } receiveValue: { dtos in
                XCTAssertFalse(dtos.isEmpty)
            }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 1)
    }

    func testFetchRepositoryDetailsSuccess() {
        let expected = Endpoint.DetailsModel(name: "CSharp-GradeBookApplication",
                                             owner: "TheGhark")
        let expectation = self.expectation(description: #function)
        sut.fetchRepository(model: expected)
            .map { $0 }
            .sink { completion in
                expectation.fulfill()
                switch completion {
                case let .failure(error):
                    XCTFail("The request should have succeeded. Failed with error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { dto in
                XCTAssertEqual(dto.name, expected.name)
                XCTAssertEqual(dto.owner.login, expected.owner)
            }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 0.5)
    }

    func testFetchRepositoryDetailsFailure() {
        let expected = Endpoint.DetailsModel(name: "",
                                             owner: "")
        let expectation = self.expectation(description: #function)
        sut.fetchRepository(model: expected)
            .mapError { $0 }
            .sink { completion in
                expectation.fulfill()
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error.localizedDescription, Endpoint.Error.invalidRepositoryDetails.localizedDescription)
                case .finished:
                    XCTFail("The request should have failed")
                }
            } receiveValue: { _ in }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 0.5)
    }

    func testFetchCommitsSuccess() {
        let expected = Endpoint.DetailsModel(name: "venues",
                                             owner: "TheGhark")
        let expectation = self.expectation(description: #function)
        sut.fetchCommits(model: expected)
            .map { $0 }
            .sink { completion in
                expectation.fulfill()
                switch completion {
                case let .failure(error):
                    XCTFail("The request should have succeeded. Failed with error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { dtos in
                XCTAssertFalse(dtos.isEmpty)
            }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 0.5)
    }

    func testFetchCommitsInvalidDetailsFailure() {
        let expected = Endpoint.DetailsModel(name: "",
                                             owner: "TheGhark")
        let expectation = self.expectation(description: #function)
        sut.fetchCommits(model: expected)
            .mapError { $0 }
            .sink { completion in
                expectation.fulfill()
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error.localizedDescription, Endpoint.Error.invalidRepositoryDetails.localizedDescription)
                case .finished:
                    XCTFail("The request should have failed")
                }
            } receiveValue: { _ in }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 0.5)
    }

    func testFetchCommitsFailure() {
        let expected = Endpoint.DetailsModel(name: "wrong-name",
                                             owner: "TheGhark")
        let expectation = self.expectation(description: #function)
        sut.fetchCommits(model: expected)
            .mapError { $0 }
            .sink { completion in
                expectation.fulfill()
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error.localizedDescription, GithubService.Error.failedRequest.localizedDescription)
                case .finished:
                    XCTFail("The request should have failed")
                }
            } receiveValue: { _ in }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 0.5)
    }
}
