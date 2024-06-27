import RealmSwift
import SwiftUI

struct ReviewFormView: View {
    @ObservedRealmObject var coffee: Coffee
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    var body: some View {
        NavigationView {
            Form {
                UserDetailsSection(viewModel: reviewViewModel)
                ReviewInputSection(viewModel: reviewViewModel)
                
                Button("Submit Review") { reviewViewModel.submitReview(for: coffee) }
                .disabled(reviewViewModel.isReviewing)
            }
            .navigationTitle("Leave a Review")
            .alert(isPresented: $reviewViewModel.showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(reviewViewModel.errorMessage ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
