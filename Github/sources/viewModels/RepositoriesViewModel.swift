import Combine
import Foundation

final class RepositoriesViewModel: ObservableObject {
    // MARK: - Types

    enum State {
        case ready
        case loading
        case failed
    }

    // MARK: - Properties

    @Published private(set) var models: [RepositoryView.Model] = []
    @Published private(set) var state: State = .ready

    private var subscriptions: [AnyCancellable] = []
    private let repository: GithubRepositoryProtocol

    // MARK: - Initialization

    init(repository: GithubRepositoryProtocol = GithubRepository()) {
        self.repository = repository
    }

    // MARK: - Internal

    func fetch() {
        repository.fetchRepositories()
            .map { $0 }
            .sink { completion in
                switch completion {
                case .failure:
                    self.state = .failed
                case .finished:
                    self.state = .ready
                }
            } receiveValue: {
                self.models = $0.map { repository in
                    .init(name: repository.name,
                          owner: repository.owner.login,
                          description: repository.description)
                }
            }
            .store(in: &subscriptions)
    }
}
