import RealmSwift
import SwiftUI

struct CoffeeListView: View {
    @ObservedResults(Coffee.self) private var coffees
    @StateObject private var coffeeViewModel = CoffeeViewModel()
    @StateObject private var reviewViewModel = ReviewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(coffeeViewModel.filteredCoffees(coffees: coffees)) { coffee in
                        NavigationLink(destination: CoffeeDetailView(
                            coffee: coffee,
                            coffeeViewModel: coffeeViewModel,
                            reviewViewModel: reviewViewModel
                            )
                        ) {
                            HStack {
                                Text(coffee.title).font(.headline)
                                Spacer()
                                if coffee.liked {
                                    Image(systemName: "heart.fill").foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
                .searchable(text: $coffeeViewModel.searchText)
                .navigationTitle("Coffees")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Picker("Sort Order", selection: $coffeeViewModel.sortOrder) {
                                Text("A-Z").tag(SortOrder.ascending)
                                Text("Z-A").tag(SortOrder.descending)
                                Text("None").tag(SortOrder.none)
                            }
                            Toggle("Show Liked Only", isOn: $coffeeViewModel.showLikedOnly)
                        } label: {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                        }
                    }
                }
            }
            .onAppear { Task { await coffeeViewModel.checkAndFetchCoffees() } }
        }
    }
}
