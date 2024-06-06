import RealmSwift
import SwiftUI

struct CoffeeListView: View {
    @ObservedResults(Coffee.self) private var coffees
    @StateObject private var viewModel = CoffeeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.filteredCoffees) { coffee in
                        NavigationLink(destination: CoffeeDetailView(viewModel: viewModel, coffee: coffee)) {
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
                .searchable(text: $viewModel.searchText)
                .navigationTitle("Coffees")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Picker("Sort Order", selection: $viewModel.sortOrder) {
                                Text("A-Z").tag(SortOrder.ascending)
                                Text("Z-A").tag(SortOrder.descending)
                                Text("None").tag(SortOrder.none)
                            }
                            Toggle("Show Liked Only", isOn: $viewModel.showLikedOnly)
                        } label: {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                        }
                    }
                }
            }
        }
    }
}
