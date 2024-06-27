import Foundation

class ReviewService {
    func submitReview(_ review: ReviewModel, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(review) else {
            completion(.failure(ReviewError.encodingError))
            return
        }
        
        guard let url = URL(string: "https://example.com/api/reviews") else {
            completion(.failure(ReviewError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }.resume()
    }
    
    enum ReviewError: Error {
        case encodingError
        case invalidURL
    }
}
