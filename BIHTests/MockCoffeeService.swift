import XCTest
@testable import BIH

final class MockCoffeeService: CoffeeServiceProtocol {
    var mockCoffees: [Coffee] = []
    var shouldThrowError = false
    
    func fetchCoffees() async throws -> [Coffee] {
        if shouldThrowError { throw URLError(.badServerResponse) }
        return mockCoffees
    }
}
