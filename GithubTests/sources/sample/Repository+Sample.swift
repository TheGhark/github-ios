import Foundation
@testable import Github

extension Repository {
    static func sample(name: String = "venues",
                       owner: Owner = .sample()) -> Self {
        .init(name: name,
              owner: owner)
    }
}

extension Repository.Owner {
    static func sample(login: String = "TheGhark") -> Self {
        .init(login: login)
    }
}
