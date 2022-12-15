import Foundation

struct Repository: Equatable {
    let name: String
    let owner: Owner
}

extension Repository {
    struct Owner: Equatable {
        let login: String
    }
}
