import Foundation

struct RepositoryDTO: Decodable {
    let name: String
    let owner: OwnerDTO
}

extension RepositoryDTO {
    struct OwnerDTO: Decodable {
        let login: String
    }
}
