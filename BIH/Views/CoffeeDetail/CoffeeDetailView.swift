import RealmSwift
import SwiftUI

struct CoffeeDetailView: View {
    @ObservedObject var viewModel: CoffeeViewModel
    @ObservedRealmObject var coffee: Coffee

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                CoffeeDetailContentView(coffee: coffee)
                CoffeeButtonView(
                    viewModel: viewModel,
                    coffee: coffee
                )
                CoffeeReviewView(
                    coffee: coffee,
                    selectedReview: $viewModel.selectedReview
                )
                Spacer()
            }
            .padding()
            .navigationTitle(coffee.title)
            .sheet(isPresented: $viewModel.isReviewing) {
                ReviewFormView(
                    viewModel: viewModel,
                    coffee: coffee
                )
            }
            .sheet(item: $viewModel.selectedReview) { review in
                CoffeeReviewContentView(review: review)
            }
        }
    }
}
