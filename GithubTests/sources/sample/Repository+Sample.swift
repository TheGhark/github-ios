import Foundation
@testable import Github

extension Repository {
    static func sample(name: String = "venues",
                       owner: Owner = .sample(),
                       description: String? = nil) -> Self {
        .init(name: name,
              owner: owner,
              description: description)
    }
}

extension Repository.Owner {
    static func sample(login: String = "TheGhark") -> Self {
        .init(login: login)
    }
}
