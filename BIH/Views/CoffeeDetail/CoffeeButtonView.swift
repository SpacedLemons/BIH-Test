import RealmSwift
import SwiftUI

struct CoffeeButtonView: View {
    @ObservedObject var coffeeViewModel: CoffeeViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    let coffee: Coffee

    var body: some View {
        VStack {
            HStack {
                Button(action: { coffeeViewModel.toggleLike(for: coffee) }) {
                    HStack {
                        Image(systemName: coffee.liked ? "heart.fill" : "heart")
                            .foregroundColor(coffee.liked ? .red : .gray)
                        Text(coffee.liked ? "Unlike" : "Like")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                Button("Leave a Review") { reviewViewModel.isReviewing.toggle() }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}
