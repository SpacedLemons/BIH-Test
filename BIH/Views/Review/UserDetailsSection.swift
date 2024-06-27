import SwiftUI

struct UserDetailsSection: View {
    @ObservedObject var viewModel: ReviewViewModel

    var body: some View {
        Section(header: Text("Your Details")) {
            TextField("Name", text: $viewModel.reviewName)
                .onChange(of: viewModel.reviewName) { oldValue, newValue in
                    if oldValue.count > 40 {
                        viewModel.reviewName = String(newValue.prefix(40))
                    }
                }
            DatePicker("Date", selection: $viewModel.reviewDate, displayedComponents: .date)
        }
    }
}
