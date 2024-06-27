import RealmSwift
import SwiftUI

struct CoffeeReviewContentView: View {
    @ObservedRealmObject var review: Review
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Text("Name: \(review.name)").font(.headline)
            Text("Date: \(review.date, formatter: dateFormatter)")
            Text("Rating: \(review.rating)/10")
            Text("Review:").font(.headline)
            Text(review.reviewDescription).font(.body)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Review Details")
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
