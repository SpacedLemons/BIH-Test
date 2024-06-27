import RealmSwift
import SwiftUI

@MainActor
final class ReviewViewModel: ObservableObject {
    @Published var isReviewing = false
    @Published var selectedReview: Review?
    @Published var reviewName = ""
    @Published var reviewDate = Date()
    @Published var reviewDescription = ""
    @Published var reviewRating = 0
    @Published var showErrorAlert = false
    @Published var errorMessage: String?
    
    private let reviewService: ReviewService
    
    init(reviewService: ReviewService = ReviewService()) {
        self.reviewService = reviewService
    }
    
    func submitReview(for coffee: Coffee) {
        let reviewModel = ReviewModel(
            name: reviewName,
            date: reviewDate,
            reviewDescription: reviewDescription,
            rating: reviewRating
        )
        
        isReviewing = true
        
        reviewService.submitReview(reviewModel) { [weak self] result in
            Task {
                guard let self else { return }
                self.isReviewing = false
                
                switch result {
                case .success: self.saveReviewLocally(for: coffee)
                case .failure(let error): print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func saveReviewLocally(for coffee: Coffee) {
        let newReview = Review()
        newReview.name = reviewName
        newReview.date = reviewDate
        newReview.reviewDescription = reviewDescription
        newReview.rating = reviewRating
        
        guard let thawedCoffee = coffee.thaw(), let realm = thawedCoffee.realm else {
            print("Error: Unable to thaw coffee object or get realm instance.")
            return
        }
        
        do {
            try realm.write { thawedCoffee.reviews.append(newReview) }
        } catch {
            print("Error: Unable to save review locally")
        }
    }
}
