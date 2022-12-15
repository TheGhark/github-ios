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

extension RepositoryDTO {
    func toDomain() -> Repository {
        .init(name: name, owner: owner.toDomain())
    }
}

extension RepositoryDTO.OwnerDTO {
    func toDomain() -> Repository.Owner {
        .init(login: login)
    }
}
