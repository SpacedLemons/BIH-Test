import Foundation

struct ReviewModel: Encodable {
    let name: String
    let date: String
    let reviewDescription: String
    let rating: Int
    
    init(name: String, date: Date, reviewDescription: String, rating: Int) {
        self.name = name
        self.date = ISO8601DateFormatter().string(from: date)
        self.reviewDescription = reviewDescription
        self.rating = rating
    }
}
