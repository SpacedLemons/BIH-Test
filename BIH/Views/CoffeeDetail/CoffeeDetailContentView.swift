import RealmSwift
import SwiftUI

struct CoffeeDetailContentView: View {
    @ObservedRealmObject var coffee: Coffee

    var body: some View {
        VStack(spacing: 16) {
            if let url = URL(string: coffee.imageURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: { ProgressView() }
                .cornerRadius(8)
            } else {
                Text("No Image Available")
            }
            
            Text("Description:").font(.headline)
            Text(coffee.descriptionText).font(.body)
            Text("Ingredients:").font(.headline)
            Text(coffee.ingredients).font(.body)
        }
        .multilineTextAlignment(.center)
    }
}
