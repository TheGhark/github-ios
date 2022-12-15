import Foundation

extension URLRequest {
    // MARK: - Types

    enum Error: Swift.Error {
        case invalidURL
    }

    // MARK: - Initialization

    init(endpoint: Endpoint) throws {
        guard let url = try endpoint.urlComponents().url else {
            throw Error.invalidURL
        }

        self.init(url: url)
        setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        setValue("Bearer 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", forHTTPHeaderField: "Authorization")
    }
}
