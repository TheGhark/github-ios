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
