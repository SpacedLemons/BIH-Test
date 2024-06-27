import RealmSwift
import SwiftUI

struct CoffeeReviewView: View {
    @ObservedRealmObject var coffee: Coffee
    @Binding var selectedReview: Review?
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Reviews").font(.headline)
            
            ForEach(coffee.reviews) { review in
                Button(action: { selectedReview = review }) {
                    VStack(spacing: 8) {
                        Text("Name: \(review.name)")
                        Text("Date: \(review.date, formatter: dateFormatter)")
                        Text("Rating: \(review.rating)/10")
                        Text("Review: \(review.reviewDescription)")
                            .lineLimit(3)
                    }
                    .padding()
                    .padding(.bottom, 8)
                    .background(Color(.systemGray6))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}
