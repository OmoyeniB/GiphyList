import Foundation

final class DetailsViewModel {
    
   static var giphID = ""
    static func fetchDetailsDataFromServer(completion: @escaping ((Result<GifItem, Error>) -> Void)) {
        
        let urlString = Constants.getGifByIDURL(id: giphID)
        guard let url = URL(string: urlString) else { return }
        
        GifNetworkCall.shared.fetchGifData(url: url, expecting: GifItem.self) { result  in
            switch result {
                case .success(let item):
                    completion(.success(item))
                case.failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
}
