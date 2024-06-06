import RealmSwift
import SwiftUI

struct ReviewFormView: View {
    @ObservedObject var viewModel: CoffeeViewModel
    @ObservedRealmObject var coffee: Coffee
    
    var body: some View {
        NavigationView {
            Form {
                UserDetailsSection(viewModel: viewModel)
                ReviewInputSection(viewModel: viewModel)
                
                Button("Submit Review") { viewModel.submitReview(for: coffee) }
            }
            .navigationTitle("Leave a Review")
        }
    }
}
