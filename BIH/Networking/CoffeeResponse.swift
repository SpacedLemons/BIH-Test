import Foundation

struct CoffeeResponse: Decodable {
    let title: String
    let description: String
    let ingredients: [String]
    let image: String
}
