import Foundation

protocol CoffeeServiceProtocol {
    func fetchCoffees() async throws -> [Coffee]
}

final class CoffeeService: CoffeeServiceProtocol {
    private let url = URL(string: "https://api.sampleapis.com/coffee/hot")!
    
    func fetchCoffees() async throws -> [Coffee] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
        
        let apiCoffees = try JSONDecoder().decode([CoffeeResponse].self, from: data)
        
        let coffees = apiCoffees.map { apiCoffee -> Coffee in
            let coffee = Coffee()
            coffee.title = apiCoffee.title
            coffee.descriptionText = apiCoffee.description
            coffee.ingredients = apiCoffee.ingredients.joined(separator: ", ")
            coffee.imageURL = apiCoffee.image
            return coffee
        }
        
        return coffees
    }
}
