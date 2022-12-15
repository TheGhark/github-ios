import Foundation

struct Commit: Equatable {
    let sha: String
    let details: Details
}

extension Commit {
    struct Details: Equatable {
        let author: Author
        let message: String
    }
}

extension Commit.Details {
    struct Author: Equatable {
        let name: String
        let email: String
        let date: Date
    }
}
