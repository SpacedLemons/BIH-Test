import Foundation
import RealmSwift

// Realm objects should never bleed outside a data tier and kept far away from code
final class Review: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var name = ""
    @Persisted var date = Date()
    @Persisted var reviewDescription = ""
    @Persisted var rating = 0
}

final class Coffee: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var title = ""
    @Persisted var descriptionText = ""
    @Persisted var ingredients = ""
    @Persisted var imageURL = ""
    @Persisted var liked = false
    @Persisted var reviews = RealmSwift.List<Review>()
}
