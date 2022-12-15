import Foundation

struct RepositoryDTO: Decodable {
    let name: String
    let owner: OwnerDTO
    let description: String?
}

extension RepositoryDTO {
    struct OwnerDTO: Decodable {
        let login: String
    }
}

extension RepositoryDTO {
    func toDomain() -> Repository {
        .init(name: name,
              owner: owner.toDomain(),
              description: description)
    }
}

extension RepositoryDTO.OwnerDTO {
    func toDomain() -> Repository.Owner {
        .init(login: login)
    }
}
