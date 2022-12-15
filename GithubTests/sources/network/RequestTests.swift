import Foundation
@testable import Github
import XCTest

final class RequestTests: XCTestCase {
    func testHeaders() throws {
        let request = try URLRequest(endpoint: .repositories)
        let acceptHeader = request.allHTTPHeaderFields?["Accept"]
        let authorizationHeader = request.allHTTPHeaderFields?["Authorization"]

        XCTAssertEqual(acceptHeader, "application/vnd.github+json")
        XCTAssertEqual(authorizationHeader, "Bearer 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")
    }

    func testListRepositoriesRequest() throws {
        let request = try URLRequest(endpoint: .repositories)
        XCTAssertEqual(request.url?.absoluteString, "https://api.github.com/user/repos")
    }
}
