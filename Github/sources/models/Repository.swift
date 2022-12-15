import Foundation

struct Repository: Equatable {
    let name: String
    let owner: Owner
    let description: String?
}

extension Repository {
    struct Owner: Equatable {
        let login: String
    }
}
