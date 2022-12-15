import Foundation

extension RepositoryView {
    struct Model: Hashable {
        let name: String
        let owner: String
        let description: String?

        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(owner)

            if let description = description {
                hasher.combine(description)
            }
        }
    }
}
