import Foundation

struct CommitDTO: Decodable {
    let sha: String
    let commit: DetailsDTO
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
