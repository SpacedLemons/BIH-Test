import Foundation

struct CoffeeModel: Decodable {
    let title: String
    let description: String
    let ingredients: [String]
    let imageURL: URL
}
