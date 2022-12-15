import SwiftUI

struct RepositoriesView: View {
    // MARK: - Properties

    @ObservedObject private var viewModel: RepositoriesViewModel

    // MARK: - Initialization

    init(viewModel: RepositoriesViewModel = .init()) {
        self.viewModel = viewModel
    }

    // MARK: - View

    var body: some View {
        ZStack {
            NavigationStack {
                switch viewModel.state {
                case .loading:
                    LoadingView(message: "Fetching your repos...")
                case .failed:
                    ErrorView {
                        viewModel.fetch()
                    }
                case .ready:
                    List {
                        ForEach(viewModel.models, id:\.self) { model in
                            NavigationLink {
                                CommitsView(viewModel: .init(detailsModel: model.detailsModel))
                            } label: {
                                RepositoryView(model: model)
                            }
                            .frame(minHeight: 45)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationTitle("Repositories")
                }
            }
        }
        .onAppear {
            viewModel.fetch()
        }
    }
}

struct RepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesView()
    }
}
