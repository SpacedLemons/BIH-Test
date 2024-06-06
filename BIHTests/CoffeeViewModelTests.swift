import RealmSwift
import XCTest
@testable import BIH

@MainActor
final class CoffeeViewModelTests: XCTestCase {
    var realm: Realm!
    var persistence: CoffeePersistence!
    var viewModel: CoffeeViewModel!

    override func setUp() {
        super.setUp()
        
        var config = Realm.Configuration()
        config.inMemoryIdentifier = self.name
        realm = try! Realm(configuration: config)
        persistence = CoffeePersistence(realm: realm)
        
        let mockService = MockCoffeeService()
        viewModel = CoffeeViewModel(service: mockService)
    }

    override func tearDown() {
        realm = nil
        persistence = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchCoffeesSuccessfully() async {
        let mockService = MockCoffeeService()
        let mockCoffee = Coffee()
        mockCoffee.title = "Latte"
        mockCoffee.descriptionText = "A delicious latte"
        mockCoffee.ingredients = "Milk, Coffee"
        mockCoffee.imageURL = "https://example.com/latte.jpg"
        mockService.mockCoffees = [mockCoffee]
        
        let viewModel = CoffeeViewModel(service: mockService)
        await viewModel.fetchAndPersistCoffees()
        
        XCTAssertEqual(viewModel.coffees.count, 1)
        XCTAssertEqual(viewModel.coffees.first?.title, "Latte")
    }
    
    func testFetchCoffeesFailure() async {
        let mockService = MockCoffeeService()
        mockService.shouldThrowError = true
        
        let viewModel = CoffeeViewModel(service: mockService)
        await viewModel.fetchAndPersistCoffees()
        
        XCTAssertTrue(viewModel.coffees.isEmpty)
    }

    func testToggleLike() {
        let coffee = Coffee()
        coffee.title = "Espresso"
        coffee.liked = false
        try! realm.write {
            realm.add(coffee)
        }

        // Verify initial liked state
        XCTAssertFalse(coffee.liked)

        // Toggle like
        viewModel.toggleLike(for: coffee)
        
        // Verify the liked property is toggled
        XCTAssertTrue(coffee.liked)

        // Toggle like again
        viewModel.toggleLike(for: coffee)
        
        // Verify the liked property is toggled back
        XCTAssertFalse(coffee.liked)
    }

    func testSaveReviewLocally() {
        // Create a coffee object and save it to Realm
        let coffee = Coffee()
        coffee.title = "Latte"
        try! realm.write { realm.add(coffee) }

        viewModel.reviewName = "John Doe"
        viewModel.reviewDate = Date(timeIntervalSince1970: 1622520000)
        viewModel.reviewDescription = "Great coffee!"
        viewModel.reviewRating = 5

        // Save review locally
        viewModel.saveReviewLocally(for: coffee)
        
        // Verify the review is added
        XCTAssertEqual(coffee.reviews.count, 1)
        XCTAssertEqual(coffee.reviews.first?.name, "John Doe")
        XCTAssertEqual(coffee.reviews.first?.reviewDescription, "Great coffee!")
        XCTAssertEqual(coffee.reviews.first?.rating, 5)
        XCTAssertEqual(coffee.reviews.first?.date, Date(timeIntervalSince1970: 1622520000))
    }
}
