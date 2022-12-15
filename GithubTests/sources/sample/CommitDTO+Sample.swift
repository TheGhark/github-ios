import Foundation
@testable import Github

extension CommitDTO {
    static func sample(sha: String = UUID().uuidString,
                       details: DetailsDTO = .sample()) -> Self {
        .init(sha: sha,
              details: details)
    }
}

extension CommitDTO.DetailsDTO {
    static func sample(author: AuthorDTO = .sample(),
                       message: String = "Add README.md") -> Self {
        .init(author: author, message: message)
    }
}

extension CommitDTO.DetailsDTO.AuthorDTO {
    static func sample(name: String = "Camilo Rodriguez Gaviria",
                       email: String = "camilorod1@gmail.com",
                       date: String = "2021-04-18T19:52:51Z") -> Self {
        .init(name: name,
              email: email,
              date: date)
    }
}
