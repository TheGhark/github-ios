import Foundation
import SwiftUI

struct CommitsView: View {
    // MARK: - Properties

    @ObservedObject private var viewModel: CommitsViewModel

    // MARK: - Initialization

    init(viewModel: CommitsViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - View

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.models, id:\.self) { model in
                    CommitView(model: model)
                }
            }
            .navigationTitle("Commits")
            .onAppear {
                viewModel.fetch()
            }
        }
    }
}

struct CommitsView_Previews: PreviewProvider {
    private static let viewModel: CommitsViewModel = .init(detailsModel: .init(name: "venues", owner: "TheGhark"))

    static var previews: some View {
        CommitsView(viewModel: viewModel)
    }
}
