import Foundation

extension URLRequest {
    // MARK: - Types

    enum Error: Swift.Error {
        case invalidURL
        case invalidToken
    }

    // MARK: - Initialization

    init(endpoint: Endpoint) throws {
        guard let url = try endpoint.urlComponents().url else {
            throw Error.invalidURL
        }

        self.init(url: url)
        setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")

        let token = try fetchAuthorizationToken()
        setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
}

private extension URLRequest {
    func fetchAuthorizationToken() throws -> String {
        guard let path = Bundle.main.path(forResource: "credentials", ofType: "plist") else {
            throw Error.invalidToken
        }

        let fileURL = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: fileURL)

        guard
            let plist = try PropertyListSerialization.propertyList(from: data,
                                                                   format: nil) as? [String: String],
            let token = plist["token"]
        else {
            throw Error.invalidToken
        }

        return token
    }
}
