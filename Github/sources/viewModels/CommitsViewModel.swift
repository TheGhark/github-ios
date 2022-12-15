import Combine
import Foundation

final class CommitsViewModel: ObservableObject {
    // MARK: - Types

    enum State {
        case ready
        case loading
        case failed
    }

    // MARK: - Properties

    @Published private(set) var state: State = .ready
    @Published private(set) var models: [CommitView.Model] = []

    private var subscriptions: [AnyCancellable] = []
    private let detailsModel: Endpoint.DetailsModel
    private let repository: GithubRepositoryProtocol

    // MARK: - Initialization

    init(repository: GithubRepositoryProtocol = GithubRepository(),
         detailsModel: Endpoint.DetailsModel) {
        self.repository = repository
        self.detailsModel = detailsModel
    }

    // MARK: - Internal

    func fetch() {
        state = .loading
        repository.fetchCommits(model: detailsModel)
            .map { $0 }
            .sink { completion in
                switch completion {
                case .failure:
                    self.state = .failed
                case .finished:
                    self.state = .ready
                }
            } receiveValue: { commits in
                self.createModels(with: commits)
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Private

private extension CommitsViewModel {
    func createModels(with commits: [Commit]) {
        let dateFormatter = RelativeDateTimeFormatter()
        models = commits.map {
            let dateString = dateFormatter.string(for: $0.details.author.date) ?? ""

            return .init(message: $0.details.message,
                         author: $0.details.author.name,
                         sha: $0.sha,
                         date: dateString)
        }
    }
}
