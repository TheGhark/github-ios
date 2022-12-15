import Foundation
import SwiftUI

struct CommitView: View {
    // MARK: - Properties

    private let model: Model

    // MARK: - Initialization

    init(model: Model) {
        self.model = model
    }

    // MARK: - View

    var body: some View {
        VStack {
            HStack {
                Text(model.message)
                    .font(.title3)
                    .bold()
                Spacer()
                Text(model.date)
                    .font(.caption)
            }
            HStack {
                Text(model.author)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                Spacer()
            }
            HStack {
                Text(model.sha)
                    .foregroundColor(.gray)
                    .font(.caption)
                Spacer()
            }
        }
    }
}

struct CommitView_Previews: PreviewProvider {
    static var dateString: String {
        let formatter = RelativeDateTimeFormatter()
        let dateString: String

        if let date = ISO8601DateFormatter().date(from: "2021-04-18T19:52:51Z") {
            dateString = formatter.string(for: date) ?? ""
        } else {
            dateString = ""
        }

        return dateString
    }

    static var previews: some View {
        CommitView(model: .init(message: "Add README.md",
                                author: "Camilo Rodriguez Gaviria",
                                sha: "1c6c9653ed7fc283e2fb36bd3b85873f3e0ae6be",
                                date: dateString))
    }
}
