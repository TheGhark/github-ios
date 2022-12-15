import Foundation

struct CommitDTO: Decodable {
    // MARK: - Types

    enum Error: Swift.Error {
        case invalidDate
    }

    // MARK: - Properties

    let sha: String
    let details: DetailsDTO

    enum CodingKeys: String, CodingKey {
        case sha
        case details = "commit"
    }
}

extension CommitDTO {
    struct DetailsDTO: Decodable {
        let author: AuthorDTO
        let message: String
    }
}

extension CommitDTO.DetailsDTO {
    struct AuthorDTO: Decodable {
        let name: String
        let email: String
        let date: String
    }
}

extension CommitDTO {
    func toDomain(with dateFormatter: ISO8601DateFormatter) throws -> Commit {
        .init(sha: sha,
              details: try details.toDomain(with: dateFormatter))
    }
}

extension CommitDTO.DetailsDTO {
    func toDomain(with dateFormatter: ISO8601DateFormatter) throws -> Commit.Details {
        .init(author: try author.toDomain(with: dateFormatter),
              message: message)
    }
}

extension CommitDTO.DetailsDTO.AuthorDTO {
    func toDomain(with dateFormatter: ISO8601DateFormatter) throws -> Commit.Details.Author {
        guard let date = dateFormatter.date(from: date) else {
            throw CommitDTO.Error.invalidDate
        }

        return .init(name: name, email: email, date: date)
    }
}
