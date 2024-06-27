import RealmSwift
import SwiftUI

struct CoffeeDetailView: View {
    @ObservedRealmObject var coffee: Coffee
    @ObservedObject var coffeeViewModel: CoffeeViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                CoffeeDetailContentView(coffee: coffee)
                CoffeeButtonView(
                    coffeeViewModel: coffeeViewModel,
                    reviewViewModel: reviewViewModel,
                    coffee: coffee
                )
                CoffeeReviewView(
                    coffee: coffee,
                    selectedReview: $reviewViewModel.selectedReview
                )
                Spacer()
            }
            .padding()
            .navigationTitle(coffee.title)
            .sheet(isPresented: $reviewViewModel.isReviewing) {
                ReviewFormView(
                    coffee: coffee,
                    reviewViewModel: reviewViewModel
                )
            }
            .sheet(item: $reviewViewModel.selectedReview) { review in
                CoffeeReviewContentView(review: review)
            }
        }
    }
}
