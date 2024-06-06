import RealmSwift
import XCTest
@testable import BIH

final class CoffeePersistenceTests: XCTestCase {
    var realm: Realm!
    var persistence: CoffeePersistence!

    override func setUp() {
        super.setUp()

        var config = Realm.Configuration()
        config.inMemoryIdentifier = self.name
        realm = try! Realm(configuration: config)
        persistence = CoffeePersistence(realm: realm)
    }

    override func tearDown() {
        realm = nil
        persistence = nil
        super.tearDown()
    }

    func testSaveCoffees() {
        let coffee = Coffee()
        coffee.title = "Espresso"
        coffee.descriptionText = "Strong coffee"
        coffee.ingredients = "Coffee"
        coffee.imageURL = "https://example.com/espresso.jpg"
        
        try! persistence.saveCoffees([coffee])
        
        let savedCoffees = persistence.loadCoffees()
        XCTAssertEqual(savedCoffees.count, 1)
        XCTAssertEqual(savedCoffees.first?.title, "Espresso")
    }

    func testLoadCoffees() {
        let coffee = Coffee()
        coffee.title = "Cappuccino"
        coffee.descriptionText = "A delicious cappuccino"
        coffee.ingredients = "Milk, Coffee"
        coffee.imageURL = "https://example.com/cappuccino.jpg"
        
        try! realm.write { realm.add(coffee) }
        
        let loadedCoffees = persistence.loadCoffees()
        XCTAssertEqual(loadedCoffees.count, 1)
        XCTAssertEqual(loadedCoffees.first?.title, "Cappuccino")
    }
}
