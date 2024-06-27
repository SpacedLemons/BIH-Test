import SwiftUI

struct ReviewInputSection: View {
    @ObservedObject var viewModel: ReviewViewModel

    var body: some View {
        Section(header: Text("Your Review")) {
            TextEditor(text: $viewModel.reviewDescription)
                .frame(height: 100)
                .onChange(of: viewModel.reviewDescription) { oldValue, newValue in
                    if oldValue.count > 300 {
                        viewModel.reviewDescription = String(newValue.prefix(300))
                    }
                }
            Picker("Rating", selection: $viewModel.reviewRating) {
                ForEach(0..<11) { index in
                    Text("\(index)").tag(index)
                }
            }
        }
    }
}
