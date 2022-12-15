import Foundation
import SwiftUI

struct RepositoryView: View {
    // MARK: - Properties

    private let model: Model

    // MARK: - Initialization

    init(model: Model) {
        self.model = model
    }

    // MARK: - View

    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(model.name)
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text(model.owner)
                        .font(.title3)
                }
                if let description = model.description {
                    HStack {
                        Text(description)
                            .font(.callout)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct RepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryView(model: .init(name: "FlexBot",
                                    owner: "abhisheksisodia",
                                    description: "FlexBot is chat bot built using Microsoft Bot Framework"))
    }
}
