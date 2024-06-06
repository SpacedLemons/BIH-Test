import RealmSwift

enum SortOrder { case ascending, descending, none }

final class CoffeeFilter {
    static func filterAndSort(coffees: [Coffee], sortOrder: SortOrder, showLikedOnly: Bool, searchText: String) -> [Coffee] {
        var result = coffees
        
        if showLikedOnly { result = result.filter { $0.liked } }
        
        if !searchText.isEmpty { result = result.filter { $0.title.lowercased().contains(searchText.lowercased()) } }
        
        switch sortOrder {
        case .ascending: result.sort { $0.title < $1.title }
        case .descending: result.sort { $0.title > $1.title }
        case .none: break
        }
        
        return result
    }
}
