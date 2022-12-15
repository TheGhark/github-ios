import Foundation

extension CommitView {
    struct Model: Hashable {
        let message: String
        let author: String
        let sha: String
        let date: String
    }
}
