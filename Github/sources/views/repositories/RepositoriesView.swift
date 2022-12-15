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
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.models, id:\.self) { model in
                        RepositoryView(model: model)
                    }
                }
            }
            .navigationTitle("Repositories")
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
