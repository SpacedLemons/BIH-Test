import RealmSwift
import SwiftUI

@main
struct BIH: SwiftUI.App {
    
    init() { configureRealm() }
    
    var body: some Scene { WindowGroup { CoffeeListView() } }
    
    /// Since we're not migrating or preserving any existing data, no further migration logic is needed here.
    /// However, migration logic would need to be introduced to handle changes between different schema versions.
    private func configureRealm() {
        let config = Realm.Configuration(schemaVersion: 0)
        Realm.Configuration.defaultConfiguration = config
    }
}
