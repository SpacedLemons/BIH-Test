import XCTest
import RealmSwift
@testable import BIH

final class CoffeeFilterTests: XCTestCase {
    var coffees: [Coffee]!

    override func setUpWithError() throws {
        super.setUp()
        coffees = [
            Coffee(value: ["title": "Espresso", "liked": false]),
            Coffee(value: ["title": "Latte", "liked": true]),
            Coffee(value: ["title": "Cappuccino", "liked": false]),
            Coffee(value: ["title": "Mocha", "liked": true])
        ]
    }

    override func tearDownWithError() throws {
        coffees = nil
        super.tearDown()
    }
    
    func testFilterAndSort_withNoFilters() throws {
        let result = CoffeeFilter.filterAndSort(
            coffees: coffees,
            sortOrder: .none,
            showLikedOnly: false,
            searchText: ""
        )
        XCTAssertEqual(result.count, 4)
    }
    
    func testFilterAndSort_withLikedOnly() throws {
        let result = CoffeeFilter.filterAndSort(
            coffees: coffees,
            sortOrder: .none,
            showLikedOnly: true,
            searchText: ""
        )
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result.allSatisfy { $0.liked })
    }
    
    func testFilterAndSort_withSearchText() throws {
        let result = CoffeeFilter.filterAndSort(
            coffees: coffees,
            sortOrder: .none,
            showLikedOnly: false,
            searchText: "Espresso"
        )
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.title, "Espresso")
    }
    
    func testFilterAndSort_withSortOrderAscending() throws {
        let result = CoffeeFilter.filterAndSort(
            coffees: coffees,
            sortOrder: .ascending,
            showLikedOnly: false,
            searchText: ""
        )
        XCTAssertEqual(result.map { $0.title }, ["Cappuccino", "Espresso", "Latte", "Mocha"])
    }
    
    func testFilterAndSort_withSortOrderDescending() throws {
        let result = CoffeeFilter.filterAndSort(
            coffees: coffees,
            sortOrder: .descending,
            showLikedOnly: false,
            searchText: ""
        )
        XCTAssertEqual(result.map { $0.title }, ["Mocha", "Latte", "Espresso", "Cappuccino"])
    }
}
