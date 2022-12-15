import Foundation
import XCTest
import Combine
@testable import Github

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

    func  testFetchRepositoriesSuccess() {
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
        wait(for: [expectation], timeout: 0.5)
    }
}
