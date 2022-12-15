import Foundation
@testable import Github

extension RepositoryDTO {
    static func sample(name: String = "venues",
                       owner: OwnerDTO = .sample()) -> Self {
        .init(name: name,
              owner: owner)
    }
}

extension RepositoryDTO.OwnerDTO {
    static func sample(login: String = "TheGhark") -> Self {
        .init(login: login)
    }
}
