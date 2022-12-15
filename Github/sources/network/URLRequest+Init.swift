import Foundation

extension URLRequest {
    // MARK: - Types

    enum Error: Swift.Error {
        case invalidURL
    }

    // MARK: - Initialization

    init(endpoint: Endpoint) throws {
        guard let url = endpoint.components?.url else {
            throw Error.invalidURL
        }

        self.init(url: url)
        setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        setValue("Bearer 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", forHTTPHeaderField: "Authorization")
    }
}
