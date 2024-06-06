import RealmSwift

final class CoffeePersistence {
    private let realm: Realm
    
    init(realm: Realm = try! Realm()) { self.realm = realm }
    
    func coffeesExist() -> Bool { return !realm.objects(Coffee.self).isEmpty }
    
    func loadCoffees() -> [Coffee] {
        let coffees = Array(realm.objects(Coffee.self))
        return coffees
    }
    
    func saveCoffees(_ coffees: [Coffee]) throws {
        do {
            try realm.write { realm.add(coffees, update: .modified) }
        } catch {
            throw error
        }
    }
}
