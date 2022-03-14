import Foundation

final class DetailsViewModel {
    
    private var allItems: [GifItem]?
    
    var items: [GifItem] {
        get {
            return allItems ?? []
        }
        set {
            allItems = newValue
        }
    }
    
    var giphID = ""
    func fetchDetailsDataFromServer(completion: @escaping ((Result<GifItem, Error>) -> Void)) {
        print(giphID, "index 9")
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
