import Foundation
import SwiftUI

struct LoadingView: View {
    // MARK: - Properties

    var message: String

    // MARK: - View

    var body: some View {
        VStack {
            ProgressView {
                Text(message)
                    .font(.title3)
            }
        }
    }
}
