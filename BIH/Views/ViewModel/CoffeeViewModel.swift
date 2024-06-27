import RealmSwift
import SwiftUI

@MainActor
final class CoffeeViewModel: ObservableObject {
    @Published var coffees: [Coffee] = []
    @Published var sortOrder: SortOrder = .none
    @Published var showLikedOnly = false
    @Published var searchText = ""
    
    private let coffeeService: CoffeeServiceProtocol
    private let coffeePersistence = CoffeePersistence()
    
    init(service: CoffeeServiceProtocol = CoffeeService()) {
        self.coffeeService = service
    }
    
    func checkAndFetchCoffees() async {
        await fetchAndPersistCoffees()
        if coffees.isEmpty { loadLocalCoffees() }
    }
    
    func fetchAndPersistCoffees() async {
        do {
            let fetchedCoffees = try await coffeeService.fetchCoffees()
            coffees = fetchedCoffees
            try coffeePersistence.saveCoffees(fetchedCoffees)
        } catch {
            print("Failed to fetch coffees: \(error)")
        }
    }
    
    func loadLocalCoffees() {
        if coffeePersistence.coffeesExist() { coffees = coffeePersistence.loadCoffees() }
    }
    
    func toggleLike(for coffee: Coffee) {
        guard let thawedCoffee = coffee.thaw(), let realm = thawedCoffee.realm else {
            print("Error: Unable to thaw coffee object or get realm instance.")
            return
        }
        do {
            try realm.write { thawedCoffee.liked.toggle() }
        } catch {
            print("Error: Unable to update coffee object: \(error.localizedDescription)")
        }
    }
    
    func filteredCoffees(coffees: Results<Coffee>) -> [Coffee] {
        return CoffeeFilter.filterAndSort(
            coffees: Array(coffees),
            sortOrder: sortOrder,
            showLikedOnly: showLikedOnly,
            searchText: searchText
        )
    }
}
