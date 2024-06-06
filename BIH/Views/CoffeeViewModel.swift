import RealmSwift
import SwiftUI

@MainActor
final class CoffeeViewModel: ObservableObject {
    @Published var isReviewing = false
    @Published var selectedReview: Review?
    @Published var reviewName = ""
    @Published var reviewDate = Date()
    @Published var reviewDescription = ""
    @Published var reviewRating = 0
    @Published var coffees: [Coffee] = []
    @Published var sortOrder: SortOrder = .none
    @Published var showLikedOnly = false
    @Published var searchText = ""
    
    private let coffeeService: CoffeeServiceProtocol
    private let coffeePersistence = CoffeePersistence()
    
    init(service: CoffeeServiceProtocol = CoffeeService()) {
        self.coffeeService = service
        Task { await checkAndFetchCoffees() }
    }
    
    /// In theory a ViewModel should never mediate data, however I feel a repository would be too overkill for such a small app so I'll stick everything in here for now
    func checkAndFetchCoffees() async {
        if coffeePersistence.coffeesExist() {
            self.coffees = coffeePersistence.loadCoffees()
        } else {
            await fetchAndPersistCoffees()
        }
    }
    
    func fetchAndPersistCoffees() async {
        do {
            let coffees = try await coffeeService.fetchCoffees()
            self.coffees = coffees
            try coffeePersistence.saveCoffees(coffees)
        } catch {
            print("Failed to fetch coffees: \(error)")
        }
    }
    
    func toggleLike(for coffee: Coffee) {
        guard let thawedCoffee = coffee.thaw(), let realm = thawedCoffee.realm else {
            print("Error: Unable to thaw coffee object or get realm instance.")
            return
        }
        try! realm.write {
            thawedCoffee.liked.toggle()
            objectWillChange.send()
        }
    }
    
    func submitReview(for coffee: Coffee) {
        let reviewData = [
            "name": reviewName,
            "date": ISO8601DateFormatter().string(from: reviewDate),
            "reviewDescription": reviewDescription,
            "rating": reviewRating
        ] as [String : Any]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: reviewData)
        let url = URL(string: "https://example.com/api/reviews")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {}
                self.saveReviewLocally(for: coffee)
                self.isReviewing = false
            }
        }.resume()
    }
    
    func saveReviewLocally(for coffee: Coffee) {
        let newReview = Review()
        newReview.name = reviewName
        newReview.date = reviewDate
        newReview.reviewDescription = reviewDescription
        newReview.rating = reviewRating
        
        guard let thawedCoffee = coffee.thaw(), let realm = thawedCoffee.realm else {
            print("Error: Unable to thaw coffee object or get realm instance.")
            return
        }
        try! realm.write { thawedCoffee.reviews.append(newReview) }
    }
    
    var filteredCoffees: [Coffee] {
        CoffeeFilter.filterAndSort(
            coffees: coffees,
            sortOrder: sortOrder,
            showLikedOnly: showLikedOnly,
            searchText: searchText
        )
    }
}
