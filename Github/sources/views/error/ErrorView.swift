import Foundation
import SwiftUI

struct ErrorView: View {
    // MARK: - Properties

    var onTryAgain: () -> Void = { }

    // MARK: - View

    var body: some View {
        VStack {
            Image(systemName: "info.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 56)
            Text("Oops! Something went wrong!")
                .font(.title3)
            Rectangle()
                .fill(.clear)
                .frame(height: 1)
            Button {
                onTryAgain()
            } label: {
                HStack {
                    Image(systemName: "repeat.circle")
                    Text("Try again")
                }
            }
            .font(.headline)
            .foregroundColor(Palette.onPrimary)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
