import Foundation
@testable import Github

extension RepositoryDTO {
    static func sample(name: String = "venues",
                       owner: OwnerDTO = .sample(),
                       description: String? = nil) -> Self {
        .init(name: name,
              owner: owner,
        description: description)
    }
}

extension RepositoryDTO.OwnerDTO {
    static func sample(login: String = "TheGhark") -> Self {
        .init(login: login)
    }
}
