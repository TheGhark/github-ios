import Foundation

extension RepositoryView {
    struct Model: Hashable {
        // MARK: - Properties

        let name: String
        let owner: String
        let description: String?

        // MARK: - Computed Properties

        var detailsModel: Endpoint.DetailsModel {
            .init(name: name, owner: owner)
        }

        // MARK: - Hashable

        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(owner)

            if let description = description {
                hasher.combine(description)
            }
        }
    }
}
